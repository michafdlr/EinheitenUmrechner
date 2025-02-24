//
//  CurrencyView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 19.02.25.
//

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
    
    func sortResults() {
        if sortedAscending {
            sortedResult = filteredResult.sorted {
                $0.key <= $1.key
            }
        } else {
            sortedResult = filteredResult.sorted {
                $0.key > $1.key
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
                                        await getData(currency: selectedCurrency)
                                    }
                                }
                            }
                        }
                    }
                    
                    Section("Target Currencies") {
                        ForEach(
                            sortedResult,
                            id: \.key
                        ) {
                            key, val in
                            HStack {
                                Text(getFullCurrencyName(from: key))
                                
                                Spacer()
                                
                                Text("\(val * amount, specifier: "%.2f")")
                                    .bold()
                            }
                        }
                    }
                    .task {
                        await getData(currency: selectedCurrency)
                        sortResults()
                    }
                    .onChange(of: sortedAscending) {
                        sortResults()
                    }
                    .onChange(of: filteredResult) {
                        sortResults()
                    }
                }
                .navigationTitle("Convert Currency")
                .toolbar {
                    SortButtonView(sortedAscending: $sortedAscending)
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
        let fullUrlString = baseUrl + currency

        guard let url = URL(string: "\(fullUrlString).json") else {
            print("URl \(fullUrlString) not found")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(
                ExchangeRatesResponse.self, from: data)
            result = decodedResponse.rates[currency] ?? [:]
        } catch {
            print("Error decoding the data.\nError: \(error)")
            return
        }
    }
}
