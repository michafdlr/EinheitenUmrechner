//
//  AddUnitSheetView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 22.02.25.
//

import SwiftUI

struct AddUnitSheetView<T: Dimension>: View {
    @Environment(\.dismiss) var dismiss
    @Binding var targetUnits: [T]
    @State private var searchText = ""
    
    let allUnits: [T]

    var filteredUnits: [T] {
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
                        }
                        .onTapGesture {
                            targetUnits.append(unit)
                            dismiss()
                        }
                    }
                    
                }
                .toolbar {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search Unit")
            }
            .navigationTitle("Select Unit")
        }
    }
}

//#Preview {
//    AddUnitSheetView()
//}
