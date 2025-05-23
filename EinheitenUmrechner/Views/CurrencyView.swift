//
//  CurrencyView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 19.02.25.
//

import SwiftData
import SwiftUI

struct CurrencyView: View {
    //    @EnvironmentObject var networkMonitor: NetworkMonitor
    @ObservedObject private var networkMonitor = NetworkMonitor()
    @EnvironmentObject var colors: colorManager

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

    // Error handling
    @State private var errorMessage: String?
    @State private var showErrorAlert = false

    @Query(
        filter: #Predicate<FavoriteCurrency> {
            $0.favorited == true
        },
        sort: \FavoriteCurrency.rawName,
        animation: .easeIn
    ) var favorites: [FavoriteCurrency]

    @Query(sort: \FavoriteCurrency.rawName) var allFavoriteCurrencies: [FavoriteCurrency]

    @Query(
        filter: #Predicate<FavoriteCurrency> {
            $0.startCurrency == true
        }
    ) var selectedCurrency: [FavoriteCurrency]

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
                    List {
                        Section {
                            HStack {
                                GeometryReader { proxy in
                                    TextField(
                                        "Currency Amount",
                                        value: $amount,
                                        format: .number,
                                        prompt: Text("Your Value")
                                    )
                                    .disabled(isLoading)
                                    .textFieldStyle(.plain)
                                    .padding(5)
                                    .font(.title3)
                                    .frame(maxWidth: .infinity)
                                    .background(colors.backgroundColor)
                                    .cornerRadius(10)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.decimalPad)
                                    .focused($valueIsFocused)
                                    .frame(width: proxy.size.width * 0.7)
                                }

                                if let selected = selectedCurrency.first {
                                    Text(selected.rawName.localizedCapitalized)
                                        .bold()
                                }
                            }
                        } header: {
                            HStack {
                                Text("Base Currency")
                                    .font(.title2)
                                    .bold()

                                Spacer()

                                if selectedCurrency.first != nil {
                                    NavigationLink {
                                        CurrencySelectionView(
                                            selectedCurrency: selectedCurrency
                                                .first!
                                        )
                                    } label: {
                                        Image(
                                            systemName: "gearshape.circle.fill"
                                        )
                                    }
                                } else {
                                    Text("No currency selected")
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                        .listRowBackground(colors.foregroundColor)

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
                                .listRowBackground(colors.foregroundColor)
                                .listRowSeparatorTint(colors.accentColor)
                                .listRowSeparator(.automatic, edges: .bottom)
                            }
                        } header: {
                            HStack {
                                Text("Favorite Currencies")
                                    .font(.title2)
                                    .bold()

                                Spacer()

                                Button(
                                    "Change Favorite Currencies",
                                    systemImage: "plus.circle.fill"
                                ) {
                                    sheetIsShowing.toggle()
                                }
                                .disabled(isLoading)
                                .labelStyle(.iconOnly)
                                .sheet(isPresented: $sheetIsShowing) {
                                    AddCurrencySheetView()
                                }
                            }
                        }
                        .listRowBackground(colors.foregroundColor)

                        if allUnitsShowing {
                            Section {
                                if isLoading {
                                    VStack {
                                        ForEach(
                                            0..<allFavoriteCurrencies.count,
                                            id: \.self
                                        ) { _ in
                                            LoadSkeletonView()
                                        }
                                    }
                                    .blinking(duration: 2)
                                } else {
                                    ForEach(sortedResult, id: \.key) {
                                        key,
                                        val in
                                        HStack {
                                            Text(
                                                "\(val * amount, specifier: "%.3f")"
                                            )
                                            .bold()

                                            Spacer()

                                            Text(getFullCurrencyName(from: key))
                                        }
                                        .swipeActions {
                                            let fullName = getFullCurrencyName(
                                                from: key
                                            ).localizedLowercase
                                            let favorited =
                                                favorites.count > 0
                                                && favorites.contains(where: {
                                                    $0.rawName
                                                        .localizedLowercase
                                                        == fullName
                                                        && $0.favorited
                                                })
                                            Button {
                                                let index =
                                                    allFavoriteCurrencies
                                                    .firstIndex(
                                                        where: {
                                                            $0.rawName
                                                                .localizedLowercase
                                                                == fullName
                                                        })!
                                                allFavoriteCurrencies[index]
                                                    .favorited
                                                    .toggle()
                                            } label: {
                                                if favorited {
                                                    Label(
                                                        "Remove Favorite",
                                                        systemImage:
                                                            "minus.circle"
                                                    )
                                                    .tint(.red)
                                                } else {
                                                    Label(
                                                        "Add Favorite",
                                                        systemImage:
                                                            "plus.circle"
                                                    )
                                                    .tint(colors.accentColor)
                                                }
                                            }
                                        }
                                    }
                                }
                            } header: {
                                HStack {
                                    Text("All Currencies")
                                        .font(.title2)
                                        .bold()
                                    Spacer()
                                    Button(
                                        "Search All Currencies",
                                        systemImage:
                                            "magnifyingglass.circle.fill"
                                    ) {
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
                            .listRowBackground(colors.foregroundColor)
                            .listRowSeparatorTint(colors.accentColor)
                            .listRowSeparator(.automatic)
                        }
                    }
                    .task {
                        if let selected = selectedCurrency.first {
                            let key =
                                String(describing: selected.name) == "inch"
                                ? "1inch" : String(describing: selected.name)
                            await getData(currency: key)
                            sortResults()
                        } else {
                            print("⚠️ No selected currency. Skipping API call.")
                        }
                    }
                    .scrollContentBackground(.hidden)
                    //                    .navigationTitle("Convert Currency")
                    .background(colors.backgroundColor)
                    .toolbar {
                        if !isLoading {
                            ToolbarItem(placement: .principal) {
                                Text("Convert Currency")
                                    .bold()
                                    .foregroundStyle(colors.textColor)
                            }
                            
                            ToolbarItemGroup(placement: .topBarTrailing) {
                                Button(
                                    "Search All Currencies",
                                    systemImage: "magnifyingglass.circle.fill"
                                ) {
                                    searchIsActive = true
                                }
                                .labelStyle(.iconOnly)
                                .disabled(isLoading)
                                
                                SortButtonView(sortedAscending: $sortedAscending)
                                    .disabled(isLoading)
                                
                                Button(allUnitsShowing ? "Hide All" : "Show All") {
                                    allUnitsShowing.toggle()
                                }
                                .foregroundStyle(colors.accentColor)
                                .disabled(isLoading)
                                
                            }
                            
                            ToolbarItem(placement: .keyboard) {
                                if valueIsFocused {
                                    Button("Done") {
                                        valueIsFocused = false
                                    }
                                    .bold()
                                }
                            }
                        }
                    }
                    .searchable(
                        text: $searchText,
                        isPresented: $searchIsActive,
                        placement: .navigationBarDrawer(
                            displayMode: .automatic
                        ),
                        prompt: "Search Target Currency"
                    )
                    .alert("Error", isPresented: $showErrorAlert) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text(errorMessage ?? "An unknown error occurred.")
                    }
                }
                .refreshable {
                    Task {
                        if let selected = selectedCurrency.first {
                            let key =
                                String(describing: selected.name) == "inch"
                                ? "1inch" : String(describing: selected.name)
                            await getData(currency: key)
                            sortResults()
                        } else {
                            print("⚠️ No selected currency. Skipping API call.")
                        }
                    }
                }
                
                if isLoading {
                    VStack {
                        Text("Loading...")
                            .font(.title)
                            .foregroundStyle(colors.accentColor)
                        ProgressView()
                            .scaleEffect(x: 2, y: 2)
                    }
                    .tint(colors.accentColor)
                    .containerRelativeFrame(
                        [.horizontal, .vertical],
                        { length, axis in
                            if axis == .vertical {
                                return 2 * length
                            }
                            return length
                        }
                    )
                    .ignoresSafeArea()
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 10))
                }
            }
        } else {
            NoInternetView()
        }
    }

    func getData(currency: String) async {
        guard networkMonitor.isConnected else {
            await MainActor.run {
                errorMessage = "No internet connection. Please try again later."
                showErrorAlert = true
            }
            return
        }

        isLoading = true
        result = [:]  // Reset results to avoid displaying stale data

        let fullUrlString = baseUrl + currency
        guard let url = URL(string: "\(fullUrlString).json") else {
            await MainActor.run {
                errorMessage = "Invalid URL. Please check the currency format."
                showErrorAlert = true
            }
            isLoading = false
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                await MainActor.run {
                    errorMessage = "Invalid response from server."
                    showErrorAlert = true
                }
                isLoading = false
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                await MainActor.run {
                    errorMessage = "Server error: \(httpResponse.statusCode)"
                    showErrorAlert = true
                }
                isLoading = false
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(
                    ExchangeRatesResponse.self,
                    from: data
                )
                result = decodedResponse.rates[currency] ?? [:]
            } catch {
                await MainActor.run {
                    errorMessage = "Failed to decode server response."
                    showErrorAlert = true
                }
                result = [:]
            }

        } catch let urlError as URLError {
            await MainActor.run {
                print(urlError)
                errorMessage = "No internet connection. Please try again later."
                showErrorAlert = true
            }
        } catch {
            await MainActor.run {
                errorMessage = "Unexpected error: \(error.localizedDescription)"
                showErrorAlert = true
            }
        }

        isLoading = false
    }

    //    func getData(currency: String) async {
    //        isLoading = true
    //
    //        let fullUrlString = baseUrl + currency
    //
    //        guard let url = URL(string: "\(fullUrlString).json") else {
    //            print("URl \(fullUrlString) not found")
    //            isLoading = false
    //            return
    //        }
    //
    //        do {
    //            let (data, response) = try await URLSession.shared.data(from: url)
    //            let decodedResponse = try JSONDecoder().decode(
    //                ExchangeRatesResponse.self, from: data)
    //            result = decodedResponse.rates[currency] ?? [:]
    //            isLoading = false
    //        } catch {
    //            print("Error decoding the data.\nError: \(error)")
    //            isLoading = false
    //            return
    //        }
    //    }
}
