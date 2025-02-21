//
//  CurrencySelectionView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 21.02.25.
//

import SwiftUI

struct CurrencySelectionView: View {
    @Binding var selectedCurrency: String
    
    var body: some View {
        NavigationStack {
            List {
                Grid(alignment: .leading) {
                    GridRow {
                        Text("Currency")
                        
                        Text("Code")
                    }
                    .font(.headline)
                    .bold()
                    
                    ForEach(Currency.allCases, id: \.self) { currency in
                        Divider()
                        GridRow {
                            Text(currency.rawValue)
                            
                            Text(currency.rawValue == "1inch" ? "1inch" : String(describing: currency))
                            
                            if selectedCurrency == String(describing: currency) || selectedCurrency == "1" + String(describing: currency) {
                                Image(systemName:  "checkmark.circle.fill")
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
                        }
                    }
                }
            }
        }
    }
}

//#Preview {
//    CurrencySelectionView()
//}
