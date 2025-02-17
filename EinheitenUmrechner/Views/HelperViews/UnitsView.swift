//
//  UnitsView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 14.02.25.
//

import SwiftUI

struct UnitsView<UnitType: Dimension>: View {
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
                        Divider()
                        GridRow {
                            Text(measureFormatter.string(from: unit))

                            Text(unit.symbol)
                            
                            if selectedUnit == unit {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                            } else {
                                Image(systemName: "checkmark.circle")
                                    .foregroundStyle(.gray)
                            }
                        }
                        .onTapGesture {
                            selectedUnit = unit
                        }
                    }
                    
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Unit")
            }
        }
    }
}
