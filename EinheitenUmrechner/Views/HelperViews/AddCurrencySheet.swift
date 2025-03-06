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
            List {
                if searchIsActive && changesMade {
                    Section{
                        Button {
                            searchIsActive = false
                            searchText = ""
                        } label: {
                            Text("Accept")
                                .bold()
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .buttonStyle(.borderedProminent)
                    }
                }
                
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
                        .foregroundStyle(currency.favorited ? .accent : .gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        currency.favorited.toggle()
                        changesMade = true
                    }
                }
            }
            .navigationTitle("Select Currency")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $searchText,
                isPresented: $searchIsActive,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "Search Currency"
            )
            .toolbar {
                Button(changesMade ? "Save" : "Cancel") {
                    dismiss()
                }
            }
        }
    }
}
