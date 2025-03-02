//
//  CurrencyView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 19.02.25.
//

import SwiftData
import SwiftUI

struct CurrencyView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor

    let baseUrl =
        "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/"

    @State private var result = [String: Double]()
    @State private var selectedCurrency = "eur"
    @State private var amount = 1.0
    @FocusState var valueIsFocused
    @State private var searchText = ""
    @State private var sortedAscending = true
    @State private var sortedResult = Array([String: Double]())
    @State private var allUnitsShowing = true
    @State private var sheetIsShowing = false
    @State private var isLoading = true

    @Query(
        filter: #Predicate<FavoriteCurrency> {
            $0.favorited == true
        }, sort: \FavoriteCurrency.rawName, animation: .easeIn) var favorites:
        [FavoriteCurrency]

    @Query(sort: \FavoriteCurrency.rawName) var allCurrencies:
        [FavoriteCurrency]

    var textFieldWidth: CGFloat {
        UIScreen.main.bounds.width * 0.5
    }

    var filteredResult: [String: Double] {
        if searchText.isEmpty {
            return result
        }
        return result.filter { (key: String, _: Double) in
            let fullName = getFullCurrencyName(from: key)
            return fullName.localizedStandardContains(searchText)
                || key.localizedStandardContains(searchText)
        }
    }

    var calculatedResults: [String: Double] {
        result.mapValues { $0 * amount }
    }

    func sortResults() {
        if sortedAscending {
            sortedResult = filteredResult.sorted {
                getFullCurrencyName(from: $0.key)
                    <= getFullCurrencyName(from: $1.key)
            }
        } else {
            sortedResult = filteredResult.sorted {
                getFullCurrencyName(from: $0.key)
                    > getFullCurrencyName(from: $1.key)
            }
        }
    }

    var body: some View {
        if networkMonitor.isConnected {
            NavigationStack {
                Form {
                    Section("Base Currency") {
                        HStack {
                            HStack {
                                TextField(
                                    "Currency Amount", value: $amount,
                                    format: .number, prompt: Text("Your Value")
                                )
                                .textFieldStyle(.roundedBorder)
                                .frame(width: textFieldWidth * 0.7)
                                .keyboardType(.decimalPad)
                                .focused($valueIsFocused)

                                Text(selectedCurrency.localizedCapitalized)
                                    .bold()
                            }
                            .frame(width: textFieldWidth)

                            Divider()

                            NavigationLink("Currency") {
                                CurrencySelectionView(
                                    selectedCurrency: $selectedCurrency
                                )
                                .onChange(of: selectedCurrency) {
                                    Task {
                                        await getData(
                                            currency: selectedCurrency)
                                    }
                                }
                            }
                        }
                    }

                    Section("Favorite Currencies") {
                        if isLoading {
                            VStack {
                                if favorites.count > 0 {
                                    ForEach(0..<favorites.count, id: \.self) { _ in
                                        LoadSkeletonView()
                                    }
                                } else {
                                    LoadSkeletonView()
                                }
                            }
//                            .blinking(duration: 2)
                        } else if favorites.isEmpty {
                            Text(
                                "No favorite units selected. Tap plus or swipe in \"All Units\" section to add favorite units."
                            )
                        } else {
                            ForEach(favorites) { favorite in
                                HStack {
                                    Text(
                                        "\(calculatedResults[String(describing: favorite.name)] ?? 0.0 * amount, specifier: "%.3f")"
                                    )
                                    .bold()

                                    Spacer()

                                    Text(favorite.rawName)
                                }
                            }
                            .onDelete { indexSet in
                                for index in indexSet {
                                    favorites[index].favorited = false
                                }
                            }
                        }
                    }

                    if allUnitsShowing {
                        Section("All Currencies") {
                            if isLoading {
                                VStack {
                                    ForEach(0..<10, id: \.self) { _ in
                                        LoadSkeletonView()
                                    }
                                }
//                                .blinking(duration: 2)
                            } else {
                                ForEach(sortedResult, id: \.key) {
                                    key, val in
                                    HStack {
                                        Text( "\(val * amount, specifier: "%.3f")")
                                        .bold()

                                        Spacer()

                                        Text(getFullCurrencyName(from: key))
                                    }
                                    .swipeActions {
                                        let fullName = getFullCurrencyName(
                                            from: key
                                        ).localizedLowercase
                                        let favorited =
                                            favorites.count > 0 && favorites.contains(where: {
                                                $0.rawName.localizedLowercase == fullName && $0.favorited
                                            })
                                        Button {
                                            let index =
                                                allCurrencies.firstIndex(
                                                    where: { $0.rawName.localizedLowercase == fullName })!
                                            allCurrencies[index].favorited
                                                .toggle()
                                        } label: {
                                            if favorited {
                                                Label(
                                                    "Remove Favorite",
                                                    systemImage: "minus.circle"
                                                )
                                                .tint(.red)
                                            } else {
                                                Label(
                                                    "Add Favorite",
                                                    systemImage: "plus.circle"
                                                )
                                                .tint(.green)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .onChange(of: sortedAscending) {
                            sortResults()
                        }
                        .onChange(of: filteredResult) {
                            sortResults()
                        }
                        .task {
                            await getData(currency: selectedCurrency)
                            sortResults()
                        }
                    }
                }
                .navigationTitle("Convert Currency")
                .toolbar {
                    Button(allUnitsShowing ? "Hide All" : "Show All") {
                        allUnitsShowing.toggle()
                    }

                    SortButtonView(sortedAscending: $sortedAscending)

                    Button(
                        "Change Favorite Units", systemImage: "plus.circle.fill"
                    ) {
                        sheetIsShowing.toggle()
                    }
                    .sheet(isPresented: $sheetIsShowing) {
                        AddCurrencySheetView()
                    }

                    if valueIsFocused {
                        Button("Done") {
                            valueIsFocused = false
                        }
                    }
                }
                .searchable(
                    text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search Target Currency"
                )
            }
        } else {
            NoInternetView()
        }
    }

    func getData(currency: String) async {
        isLoading = true
        
        let fullUrlString = baseUrl + currency

        guard let url = URL(string: "\(fullUrlString).json") else {
            print("URl \(fullUrlString) not found")
            isLoading = false
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(
                ExchangeRatesResponse.self, from: data)
                result = decodedResponse.rates[currency] ?? [:]
                isLoading = false
        } catch {
            print("Error decoding the data.\nError: \(error)")
            isLoading = false
            }
    }
}
