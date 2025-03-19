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
    @EnvironmentObject var colors: colorManager
    
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
        NavigationStack {
            List {
                Section {
                    HStack {
                        Text(
                            "\(selectedCurrency.rawName) (\(String(describing: selectedCurrency.name)))"
                        )
                        .bold()
                        
                        Spacer()
                        
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(colors.accentColor)
                    }
                } header: {
                    Text("Selected Currency")
                        .font(.title2)
                        .bold()
                }
                .listRowBackground(colors.foregroundColor)
                
                Section {
                    HStack {
                        Text("Currency")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        Text("Code")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        Spacer()
                        
                        Text("Selected")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .font(.headline)
                    .bold()
                    
                    ForEach(filteredCurrencies, id: \.self) { currency in
                        HStack {
                            Text(currency.rawValue)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            Text(currency.rawValue == "1inch" ? "1inch" : String(describing: currency))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                            Spacer()
                            
                            
                            Image(systemName: selectedCurrency.name == currency ? "checkmark.circle.fill" : "checkmark.circle")
                                .foregroundStyle(selectedCurrency.name == currency ? colors.accentColor : colors.backgroundColor)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if selectedCurrency.name != currency {
                                selectedCurrency.startCurrency = false
                                let newSelection = currencies.first {$0.name == currency}!
                                newSelection.startCurrency = true
                            }
                            searchIsPresented = false
                            searchText = ""
                            selectionChanged = true
                        }
                    }
                }
                header: {
                    HStack {
                        Text("Available Currencies")
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                        
                        Button("Search Currency", systemImage: "magnifyingglass.circle.fill") {
                            searchIsPresented = true
                        }
                        .labelStyle(.iconOnly)
                    }
                }
                .listRowBackground(colors.foregroundColor)
                .listRowSeparatorTint(colors.accentColor)
                .listRowSeparator(.automatic)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Select Base Currency")
                        .foregroundStyle(colors.textColor)
                        .bold()
                    }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(selectionChanged ? "Accept" : "Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(colors.accentColor)
                }
            }
            .searchable(
                text: $searchText,
                isPresented: $searchIsPresented,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: Text("Search Currency"))
//            .navigationTitle("Select Base Currency")
//            .toolbarColorScheme(.dark, for: .navigationBar)
            .scrollContentBackground(.hidden)
            .background(colors.backgroundColor)
        }
    }
}
