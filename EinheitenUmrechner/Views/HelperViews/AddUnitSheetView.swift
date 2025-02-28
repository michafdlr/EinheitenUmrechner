//
//  AddUnitSheetView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 22.02.25.
//

import SwiftUI
import SwiftData

struct AddUnitSheetView<T: Dimension>: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Bindable var category: CategoryName
    @State private var searchText = ""
    @State private var changesMade = false
    @State private var sortedUnits: [T] = []
    
    let allUnits: [T]
    
    var filteredUnits: [T] {
        if searchText.isEmpty {
            return sortedUnits
        }
        return sortedUnits.filter {
            measureFormatter.string(from: $0).localizedCaseInsensitiveContains(searchText) || $0.symbol.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    func sortUnits() {
        sortedUnits.sort {
            measureFormatter.string(from: $0) <= measureFormatter.string(from: $1)
        }
    }
    
    func addFavorite(_ favorite: Favorite) {
        if !category.favorites.contains(where: {$0.unitSymbol == favorite.unitSymbol}) {
            modelContext.insert(favorite)
            category.favorites.append(favorite)
        }
    }
    
    func filterFavorites(by unit: T) -> [Favorite]{
        return category.favorites.filter({$0.unitSymbol == unit.symbol})
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
                        
                        Text("Selected")
                    }
                    .font(.headline)
                    .bold()

                    ForEach(filteredUnits, id: \.self) { unit in
                        Divider()
                        GridRow {
                            Text(measureFormatter.string(from: unit))

                            Text(unit.symbol)
                            
                            if category.favorites.contains(where: {$0.unitSymbol == unit.symbol}) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                            } else {
                                Image(systemName: "checkmark.circle")
                            }
                        }
                        .onTapGesture {
                            let filteredFavorites = filterFavorites(by: unit)
                            if filteredFavorites.isEmpty {
                                let favorite = Favorite(name: unit, categoryName: category)
                                addFavorite(favorite)
                            } else {
                                filteredFavorites.forEach { favorite in
                                    modelContext.delete(favorite)
                                }
                                category.favorites.removeAll {$0.unitSymbol == unit.symbol}
                            }
                            changesMade = true
                        }
                    }
                    
                }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Unit")
                .toolbar {
                    Button(changesMade ? "Save" : "Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Select Unit")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            sortedUnits = allUnits
            sortUnits()
        }
        .onChange(of: searchText) {
            sortUnits()
        }
    }
}

//#Preview {
//    AddUnitSheetView()
//}
