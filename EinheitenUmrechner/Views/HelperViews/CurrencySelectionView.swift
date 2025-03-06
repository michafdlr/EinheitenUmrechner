//
//  CurrencySelectionView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 21.02.25.
//

import SwiftUI
import SwiftData

struct CurrencySelectionView: View {
    @Environment(\.dismiss) var dismiss
    
    @Query var currencies: [FavoriteCurrency]
    @Bindable var selectedCurrency: FavoriteCurrency
    @State private var searchText = ""
    @State private var searchIsPresented = false
    @State private var selectionChanged = false

    var filteredCurrencies: [Currency] {
        if searchText.isEmpty {
            return Currency.allCases
        }

        return Currency.allCases.filter {
            $0.rawValue.localizedStandardContains(searchText)
                || String(describing: $0).localizedStandardContains(searchText)
        }
    }

    var body: some View {
        Form {
            Section("Selected Currency") {
                HStack {
                    Text(
                        "\(selectedCurrency.rawName) (\(String(describing: selectedCurrency.name)))"
                    )
                    .bold()

                    Spacer()

                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                }
            }

            Section("Available Currencies") {
                Grid(alignment: .leading, horizontalSpacing: 15, verticalSpacing: 15) {
                    GridRow {
                        Text("Currency")

                        Text("Code")
                    }
                    .font(.headline)
                    .bold()

                    ForEach(filteredCurrencies, id: \.self) { currency in
                        Divider()
                        GridRow {
                            Text(currency.rawValue)

                            Text(
                                currency.rawValue == "1inch"
                                    ? "1inch" : String(describing: currency))

                            if selectedCurrency.name == currency
//                                || selectedCurrency == "1"
//                                    + String(describing: currency)
                            {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                            } else {
                                Image(systemName: "checkmark.circle")
                                    .foregroundStyle(.gray)
                            }
                        }
                        .onTapGesture {
                            if selectedCurrency.name != currency {
                                selectedCurrency.startCurrency = false
                                let newSelection = currencies.first {$0.name == currency}!
                                newSelection.startCurrency = true
                            }
//                            if currency.rawValue == "1inch" {
//                                selectedCurrency = "1inch"
//                            } else {
//                                selectedCurrency = String(describing: currency)
//                            }
                            searchIsPresented = false
                            searchText = ""
                            selectionChanged = true
                        }
                    }
                }
                .toolbar {
                    Button(selectionChanged ? "Accept" : "Cancel") {
                        dismiss()
                    }
                }
                .searchable(
                    text: $searchText,
                    isPresented: $searchIsPresented,
                    placement: .navigationBarDrawer(displayMode: .automatic),
                    prompt: Text("Search Currency"))
            }
            .navigationTitle("Select Base Currency")
        }
    }
}
