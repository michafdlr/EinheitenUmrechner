//
//  AddCurrencySheet.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 01.03.25.
//

import SwiftUI
import SwiftData

struct AddCurrencySheetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \FavoriteCurrency.rawName) var currencies: [FavoriteCurrency]
    @State private var searchText = ""
    @State private var changesMade = false
    
    var filteredCurrencies: [FavoriteCurrency] {
        if searchText.isEmpty {
            return currencies
        }
        return currencies.filter {
            $0.name.rawValue.localizedStandardContains(searchText) || String(describing: $0.name).localizedStandardContains(searchText)
        }
    }
    
    
//    func filterFavorites(by name: String) -> [FavoriteCurrency]{
//        return currencies.filter({$0.name.rawValue == name})
//    }
    
    var body: some View {
        NavigationStack {
            List {
                Grid(
                    alignment: .leading, horizontalSpacing: 10,
                    verticalSpacing: 15
                ) {

                    GridRow {
                        Text("Currency")

                        Text("Symbol")
                        
                        Text("Selected")
                    }
                    .font(.headline)
                    .bold()

                    ForEach(filteredCurrencies) { currency in
                        Divider()
                        GridRow {
                            Text(currency.name.rawValue)

                            Text(String(describing: currency.name))
                            
                            if currency.favorited {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                            } else {
                                Image(systemName: "checkmark.circle")
                            }
                        }
                        .onTapGesture {
                            currency.favorited.toggle()
                            changesMade = true
                        }
                    }
                    
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search Currency")
                .toolbar {
                    Button(changesMade ? "Save" : "Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Select Currency")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
//            sortedUnits = allUnits
//            sortUnits()
        }
        .onChange(of: searchText) {
//            sortUnits()
        }
    }
}
