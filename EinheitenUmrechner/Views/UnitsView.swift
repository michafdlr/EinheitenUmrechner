//
//  UnitsView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 10.02.25.
//

import SwiftUI

struct UnitsView: View {
    @Binding var selected: UnitLength
    @State private var searchText = ""

    var filteredUnits: [UnitLength] {
        if searchText.isEmpty {
            return allUnits
        }
        return allUnits.filter {
            formatter.string(from: $0).localizedCaseInsensitiveContains(searchText) || $0.symbol.localizedCaseInsensitiveContains(searchText)
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
                        Text("Maß")

                        Text("Symbol")
                    }
                    .font(.headline)
                    .bold()

                    ForEach(filteredUnits, id: \.self) { unit in
                        Divider()
                        GridRow {
                            Text(formatter.string(from: unit))

                            Text(unit.symbol)
                            
                            if selected == unit {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                            } else {
                                Image(systemName: "checkmark.circle")
                                    .foregroundStyle(.gray)
                            }
                        }
                        .onTapGesture {
                            selected = unit
                        }
                    }
                    
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Einheit suchen")
            }
        }
    }
}

//#Preview {
//    UnitsView(selected: UnitLength.centimeters)
//}
