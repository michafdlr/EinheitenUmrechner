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
    @EnvironmentObject var colors: colorManager
    
    @Bindable var category: CategoryName
    @State private var searchText = ""
    @State private var changesMade = false
    @State private var sortedUnits: [T] = []
    @State private var searchIsActive = false
    
    let allUnits: [T]
    
    var filteredUnits: [T] {
        if searchText.isEmpty {
            return sortedUnits
        }
        return sortedUnits.filter {
            measureFormatter.string(from: $0).localizedStandardContains(searchText) || $0.symbol.localizedStandardContains(searchText)
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
                .listRowBackground(colors.foregroundColor)
            }
            
            List {
                HStack{
                    Text("Unit")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Symbol")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text("Selected")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .font(.headline)
                .bold()
                .listRowBackground(colors.foregroundColor)
                .listRowSeparatorTint(colors.accentColor)
                .listRowSeparator(.automatic)
                
                ForEach(filteredUnits, id: \.self) { unit in
                    HStack {
                        Text(measureFormatter.string(from: unit))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        Text(unit.symbol)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        Image(systemName: category.favorites.contains(where: {$0.unitSymbol == unit.symbol}) ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundStyle(category.favorites.contains(where: {$0.unitSymbol == unit.symbol}) ? colors.accentColor : colors.backgroundColor)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .contentShape(Rectangle())
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
                .listRowBackground(colors.foregroundColor)
                .listRowSeparatorTint(colors.accentColor)
                .listRowSeparator(.automatic)
                
            }
            .searchable(text: $searchText, isPresented: $searchIsActive, placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Search Unit")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Select Unit")
                        .foregroundStyle(colors.textColor)
                        .bold()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(changesMade ? "Save" : "Cancel") {
                        dismiss()
                    }
                    .foregroundStyle(colors.accentColor)
                }
            }
            .scrollContentBackground(.hidden)
            .background(colors.backgroundColor)
//            .navigationTitle("Select Unit")
//            .navigationBarTitleDisplayMode(.inline)
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
