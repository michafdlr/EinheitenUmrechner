//
//  CurrencySelectionView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 21.02.25.
//

import SwiftUI

struct CurrencySelectionView: View {
    @Binding var selectedCurrency: String
    @State private var searchText = ""
    @State private var searchIsPresented = false

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
                        "\(getFullCurrencyName(from: selectedCurrency)) (\(selectedCurrency))"
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

                            if selectedCurrency == String(describing: currency)
                                || selectedCurrency == "1"
                                    + String(describing: currency)
                            {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                            } else {
                                Image(systemName: "checkmark.circle")
                                    .foregroundStyle(.gray)
                            }
                        }
                        .onTapGesture {
                            if currency.rawValue == "1inch" {
                                selectedCurrency = "1inch"
                            } else {
                                selectedCurrency = String(describing: currency)
                            }
                            searchIsPresented = false
                            searchText = ""
                        }
                    }
                }
                .searchable(
                    text: $searchText,
                    isPresented: $searchIsPresented,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: Text("Search Currency"))
            }
            .navigationTitle("Select Base Currency")
        }
    }
}

//#Preview {
//    CurrencySelectionView()
//}
