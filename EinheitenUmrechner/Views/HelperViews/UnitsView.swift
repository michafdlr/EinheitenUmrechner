//
//  UnitsView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 14.02.25.
//

import SwiftUI

struct UnitsView<UnitType: Dimension>: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var colors: colorManager
    
    @Binding var selectedUnit: UnitType
    @State private var searchText = ""
    
    let allUnits: [UnitType]

    var filteredUnits: [UnitType] {
        if searchText.isEmpty {
            return allUnits
        }
        return allUnits.filter {
            measureFormatter.string(from: $0).localizedCaseInsensitiveContains(searchText) || $0.symbol.localizedCaseInsensitiveContains(searchText)
        }
    }
    var body: some View {
        NavigationStack {
            List {
                Grid(
                    alignment: .leading, horizontalSpacing: 10,
                    verticalSpacing: 15
                ) {

                    GridRow {
                        Text("Unit")

                        Text("Symbol")
                    }
                    .font(.headline)
                    .bold()

                    ForEach(filteredUnits, id: \.self) { unit in
                        Rectangle()
                            .frame(height: 2)
                            .foregroundStyle(colors.accentColor)
                        GridRow {
                            Text(measureFormatter.string(from: unit))

                            Text(unit.symbol)
         
                            Image(systemName: selectedUnit == unit ? "checkmark.circle.fill" : "checkmark.circle")
                                .foregroundStyle(selectedUnit == unit ? colors.accentColor : colors.backgroundColor)
                            
                        }
                        .onTapGesture {
                            selectedUnit = unit
                        }
                    }
                }
                .listRowBackground(colors.foregroundColor)
                .listRowSeparatorTint(colors.accentColor)
                .listRowSeparator(.automatic)
            }
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("Select Base Unit")
                        .foregroundStyle(colors.textColor)
                        .bold()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Accept") {
                        dismiss()
                    }
                    .foregroundStyle(colors.accentColor)
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Unit")
            .scrollContentBackground(.hidden)
            .background(colors.backgroundColor)
        }
    }
}
