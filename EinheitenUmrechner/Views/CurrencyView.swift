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
    @State private var amount = 1.0
    @FocusState var valueIsFocused
    @State private var searchText = ""
    @State private var sortedAscending = true
    @State private var sortedResult = Array([String: Double]())
    @State private var allUnitsShowing = true
    @State private var sheetIsShowing = false
    @State private var isLoading = true
    @State private var searchIsActive = false

    @Query(
        filter: #Predicate<FavoriteCurrency> {
            $0.favorited == true
        }, sort: \FavoriteCurrency.rawName, animation: .easeIn) var favorites:
        [FavoriteCurrency]

    @Query(sort: \FavoriteCurrency.rawName) var allFavoriteCurrencies:
        [FavoriteCurrency]
    
    @Query(filter: #Predicate<FavoriteCurrency> {
        $0.startCurrency == true
    }) var selectedCurrency: [FavoriteCurrency]

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
        result.mapValues { value in
                value * amount
            }.merging(["inch": (result["1inch"] ?? 0.0) * amount]) { _, new in new }
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
            ZStack {
                NavigationStack {
                    Form {
                        Section {
                            HStack {
                                HStack {
                                    TextField(
                                        "Currency Amount", value: $amount,
                                        format: .number, prompt: Text("Your Value")
                                    )
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.decimalPad)
                                    .focused($valueIsFocused)
                                    
                                    
                                    Text(selectedCurrency.first!.rawName.localizedCapitalized)
                                        .bold()
                                }
                                .containerRelativeFrame(.horizontal) { length, _ in
                                    return 0.65 * length
                                }
                                
                                Divider()
                                
                                NavigationLink("Currency") {
                                    CurrencySelectionView(
                                        selectedCurrency: selectedCurrency.first!
                                    )
                                    .onChange(of: selectedCurrency.first!.rawName) {
                                        Task {
                                            let key = String(describing: selectedCurrency.first!.name)
                                            await getData(
                                                currency: String(describing: key == "inch" ? "1inch" : key))
                                        }
                                    }
                                }
                                .containerRelativeFrame(.horizontal) { length, _ in
                                    return 0.25 * length
                                }
                            }
                        }
                        header: {
                            Text("Base Currency")
                                .font(.title2)
                                .bold()
                        }
                        
                        Section {
                            if isLoading {
                                VStack {
                                    if favorites.count > 0 {
                                        ForEach(0..<favorites.count, id: \.self) { _ in
                                            LoadSkeletonView()
                                        }
                                    }
                                }
                                .blinking(duration: 2)
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
                        } header: {
                            HStack {
                                Text("Favorite Currencies")
                                    .font(.title2)
                                    .bold()
                                
                                Spacer()
                                
                                Button(
                                    "Change Favorite Currencies", systemImage: "plus.circle.fill"
                                ) {
                                    sheetIsShowing.toggle()
                                }
                                .labelStyle(.iconOnly)
                                .sheet(isPresented: $sheetIsShowing) {
                                    AddCurrencySheetView()
                                }
                            }
                        }
                        
                        if allUnitsShowing {
                            Section {
                                if isLoading {
                                    VStack {
                                        ForEach(0..<allFavoriteCurrencies.count , id: \.self) { _ in
                                            LoadSkeletonView()
                                        }
                                    }
                                    .blinking(duration: 2)
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
                                                allFavoriteCurrencies.firstIndex(
                                                    where: { $0.rawName.localizedLowercase == fullName })!
                                                allFavoriteCurrencies[index].favorited
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
                            header: {
                                HStack {
                                    Text("All Currencies")
                                        .font(.title2)
                                        .bold()
                                    Spacer()
                                    Button("Search All Currencies", systemImage: "magnifyingglass.circle.fill") {
                                        searchIsActive = true
                                    }
                                    .labelStyle(.iconOnly)
                                }
                                    
                            }
                            .onChange(of: sortedAscending) {
                                sortResults()
                            }
                            .onChange(of: filteredResult) {
                                sortResults()
                            }
                        }
                    }
                    .task {
                        let key = String(describing: selectedCurrency.first!.name)
                        await getData(currency: String(describing: key == "inch" ? "1inch" : key))
                        sortResults()
                    }
                    .navigationTitle("Convert Currency")
                    .toolbar {
                        Button(allUnitsShowing ? "Hide All" : "Show All") {
                            allUnitsShowing.toggle()
                        }
                        
                        SortButtonView(sortedAscending: $sortedAscending)
                        
                        if valueIsFocused {
                            Button("Done") {
                                valueIsFocused = false
                            }
                        }
                    }
                    .searchable(
                        text: $searchText,
                        isPresented: $searchIsActive,
                        placement: .navigationBarDrawer(displayMode: .automatic),
                        prompt: "Search Target Currency"
                    )
                }
                
                if isLoading {
                    VStack {
                        Text("Loading...")
                            .font(.title)
                            .foregroundStyle(.accent)
                        ProgressView()
                            .scaleEffect(x: 2, y: 2)
                    }
                    .tint(.accentColor)
                    .containerRelativeFrame([.horizontal, .vertical], { length, axis in
                        return 0.75 * length
                    })
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 10))
                }
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
