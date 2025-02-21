//
//  CurrencyView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 19.02.25.
//

import SwiftUI

struct CurrencyView: View {
    let baseUrl =
        "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/"

    @State private var result = [String: Double]()
    @State private var selectedCurrency = "eur"
    @State private var amount = 1.0
    @FocusState var valueIsFocused
    @State private var searchText = ""
    
    var textFieldWidth: CGFloat {
        UIScreen.main.bounds.width * 0.5
    }
    
    
    var filteredResult: [String: Double] {
        if searchText.isEmpty {
            return result
        }
        return result.filter { (key: String, _: Double) in
            let fullName = getFullCurrencyName(from: key)
            return fullName.localizedStandardContains(searchText) || key.localizedStandardContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Base Currency") {
                    HStack {
                        HStack {
                            TextField("Currency Amount", value: $amount, format: .number, prompt: Text("Your Value"))
                                .textFieldStyle(.roundedBorder)
                                .frame(width: textFieldWidth * 0.7)
                                .keyboardType(.decimalPad)
                                .focused($valueIsFocused)
                            
                            Text(selectedCurrency.localizedCapitalized)
                        }
                        .frame(width: textFieldWidth)
                        
                        Divider()
                        
                        NavigationLink("Currency") {
                            CurrencySelectionView(selectedCurrency: $selectedCurrency)
                                .onChange(of: selectedCurrency) {
                                    Task {
                                        await getData(currency: selectedCurrency)
                                    }
                                }
                        }
                    }
                }
                
                Section("Target Currencies") {
                    ForEach(filteredResult.sorted(by: { $0.key < $1.key }), id: \.key) {
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
                }
            }
            .navigationTitle("Convert Currency")
            .toolbar {
                if valueIsFocused {
                    Button("Done") {
                        valueIsFocused = false
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search Currency")
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
            print("Success")
        } catch {
            print("Error decoding the data \(error)")
            return
        }
    }

    func getFullCurrencyName(from currency: String) -> String {
        Currency.allCases.first { String(describing: $0) == currency }?.rawValue
            ?? currency.localizedCapitalized
    }
}

//#Preview {
//    CurrencyView()
//}


//                Picker("Base Currency", selection: $selectedCurrency) {
//                    ForEach(Currency.allCases, id: \.self) { currency in
//                        Text(currency.rawValue)
//                            .tag(String(describing: currency))
//                    }
//                }
