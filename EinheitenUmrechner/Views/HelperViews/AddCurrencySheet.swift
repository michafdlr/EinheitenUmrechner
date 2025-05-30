//
//  AddCurrencySheet.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 01.03.25.
//

import SwiftData
import SwiftUI

struct AddCurrencySheetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var colors: colorManager

    @Query(sort: \FavoriteCurrency.rawName) var currencies: [FavoriteCurrency]
    @State private var searchText = ""
    @State private var changesMade = false
    @State private var searchIsActive = false

    var filteredCurrencies: [FavoriteCurrency] {
        if searchText.isEmpty {
            return currencies
        }
        return currencies.filter {
            $0.name.rawValue.localizedStandardContains(searchText)
                || String(describing: $0.name).localizedStandardContains(
                    searchText)
        }
    }

    //    func filterFavorites(by name: String) -> [FavoriteCurrency]{
    //        return currencies.filter({$0.name.rawValue == name})
    //    }

    var body: some View {
        NavigationStack {
            if searchIsActive && changesMade {
                Button {
                    searchIsActive = false
                    searchText = ""
                } label: {
                    Text("Accept")
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .foregroundStyle(colors.accentColor)
                        .bold()
                        .background(colors.backgroundColor)
                        .clipShape(.rect(cornerRadius: 5))
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            List {
                Section {
                    HStack {
                        Text("Currency")
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Spacer()

                        Text("Symbol")
                            .frame(maxWidth: .infinity, alignment: .trailing)

                        Spacer()

                        Text("Selected")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .font(.headline)
                    .bold()

                    ForEach(filteredCurrencies) { currency in
                        HStack {
                            Text(currency.name.rawValue)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Spacer()

                            Text(String(describing: currency.name))
                                .frame(maxWidth: .infinity, alignment: .trailing)

                            Spacer()

                            Image(
                                systemName: currency.favorited
                                    ? "checkmark.circle.fill" : "checkmark.circle"
                            )
                            .foregroundStyle(
                                currency.favorited
                                    ? colors.accentColor : colors.backgroundColor
                            )
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .font(.callout)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            currency.favorited.toggle()
                            changesMade = true
                        }
                    }
                } header: {
                    Text("All Currencies")
                        .font(.title2)
                        .bold()
                }
                .listRowBackground(colors.foregroundColor)
                .listRowSeparatorTint(colors.accentColor)
                .listRowSeparator(.automatic)
            }
            //            .navigationTitle("Select Currency")
            //            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $searchText,
                isPresented: $searchIsActive,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "Search Currency"
            )
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Select Currency")
                        .foregroundStyle(colors.textColor)
                        .font(.headline)
                        .bold()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(changesMade ? "Save" : "Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(colors.accentColor)
                }

                ToolbarItem(placement: .keyboard) {
                    Button(
                        "Search All Currencies",
                        systemImage: "magnifyingglass.circle.fill"
                    ) {
                        searchIsActive = true
                    }
                    .labelStyle(.iconOnly)
                    .foregroundStyle(colors.accentColor)
                }
            }
            .scrollContentBackground(.hidden)
            .background(colors.backgroundColor)
            .textCase(nil)
        }
    }
}
