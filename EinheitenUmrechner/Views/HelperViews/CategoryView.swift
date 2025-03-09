//
//  CategoryView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 16.02.25.
//

import SwiftData
import SwiftUI

struct CategoryView<T: Dimension>: View {
    @Environment(\.modelContext) var modelContext

    @FocusState.Binding var valueIsFocused: Bool
    @Binding var startUnit: T
    @Binding var startValue: Double
    @Binding var sortedUnits: [T]

    var allUnits: [T]
    let textFieldName: String
    let standardUnit: T
    let title: LocalizedStringResource

    @State private var allUnitsShowing = true
    @State private var searchText = ""
    @State private var sheetIsShowing = false
    @State private var unitsSortedAscending = true
    @State private var sortedFavorites = [Favorite]()
    @State private var searchIsActive = false

    var textInputWidth: CGFloat {
        UIScreen.main.bounds.width * 0.5
    }

    var valueMeasure: Measurement<T> {
        Measurement(value: startValue, unit: startUnit)
    }

    @Query var categoryNames: [CategoryName]

    var category: CategoryName {
        categoryNames.first {
            $0.name.localizedLowercase == textFieldName.localizedLowercase
        } ?? CategoryName(name: "Not found")
    }

    var favorites: [Favorite] {
        category.favorites
    }

    var filteredUnits: [T] {
        if searchText.isEmpty {
            return sortedUnits
        }
        return sortedUnits.filter {
            measureFormatter.string(from: $0).localizedStandardContains(
                searchText) || $0.symbol.localizedStandardContains(searchText)
        }
    }

    func sortFavorites() {
        sortedFavorites = favorites.sorted { fav1, fav2 in
            guard let unit1 = getUnit(from: fav1.unitSymbol) as? T,
                  let unit2 = getUnit(from: fav2.unitSymbol) as? T else {return false}
            if unitsSortedAscending {
                return measureFormatter.string(from: unit1).localizedLowercase
                <= measureFormatter.string(from: unit2).localizedLowercase
            }
            return measureFormatter.string(from: unit1).localizedLowercase
                > measureFormatter.string(from: unit2).localizedLowercase
        }
    }

    func sortAllUnits() {
        if unitsSortedAscending {
            sortedUnits = allUnits.sorted {
                measureFormatter.string(from: $0).localizedLowercase
                    <= measureFormatter.string(from: $1).localizedLowercase
            }
        } else {
            sortedUnits = allUnits.sorted {
                measureFormatter.string(from: $0).localizedLowercase
                    > measureFormatter.string(from: $1).localizedLowercase
            }
        }
    }

    func deleteFavorites(_ indexSet: IndexSet) {
        for index in indexSet {
            let favorite = sortedFavorites[index]
            modelContext.delete(favorite)
            category.favorites.removeAll {
                $0.unitSymbol == favorite.unitSymbol
            }
        }
    }

    func modifyFavorites(unit: T) {
        let favorite = Favorite(name: unit, categoryName: category)
        if category.favorites.contains(where: { $0.unitSymbol == unit.symbol })
        {
            modelContext.delete(favorite)
            category.favorites.removeAll { $0.unitSymbol == unit.symbol }
        } else {
            modelContext.insert(favorite)
            category.favorites.append(favorite)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    StartValueView(
                        textFieldName: textFieldName,
//                        textInputWidth: textInputWidth,
                        valueIsFocused: $valueIsFocused,
                        inputValue: $startValue,
                        startUnit: $startUnit,
                        allUnits: allUnits)
                } header: {
                    HStack{
                        Text("Base Unit")
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                        
                        NavigationLink {
                            UnitsView(selectedUnit: $startUnit, allUnits: allUnits)
                        } label: {
                            Image(systemName: "gearshape.circle.fill")
                        }

                    }
                }

                Section {
                    if favorites.isEmpty {
                        Text(
                            "No favorite units selected. Tap plus or swipe in \"All Units\" section to add favorite units."
                        )
                    } else {
                        ForEach(sortedFavorites) { favorite in
                            if let unit =
                                getUnit(from: favorite.unitSymbol) as? T {
                                TargetUnitView(
                                    targetValue: getTargetValue(
                                        targetUnit: unit,
                                        measure: valueMeasure),
                                    textInputWidth: textInputWidth * 2,
                                    targetUnit: .constant(unit),
                                    allUnits: allUnits
                                )
                            }
                        }
                        .onDelete(perform: deleteFavorites)
                        .onChange(of: unitsSortedAscending) {
                            withAnimation(.easeInOut) {
                                sortFavorites()
                            }
                        }
                        .onChange(of: category.favorites) {
                            sortFavorites()
                        }
                    }
                }
                header: {
                    HStack{
                        Text("Favorite Units")
                            .font(.title2)
                            .bold()
                        Spacer()
                        Button("Change Favorite Units", systemImage: "plus.circle.fill")
                        {
                            sheetIsShowing.toggle()
                        }
                        .labelStyle(.iconOnly)
                    }
                    
                }

                if allUnitsShowing {
                    Section {
                        ForEach(filteredUnits.indices, id: \.self) { index in
                            TargetUnitView(
                                targetValue: getTargetValue(
                                    targetUnit: filteredUnits[index],
                                    measure: valueMeasure),
                                textInputWidth: textInputWidth * 2,
                                targetUnit: .constant(filteredUnits[index]),
                                allUnits: allUnits
                            )
                            .swipeActions {
                                Button {
                                    modifyFavorites(unit: filteredUnits[index])
                                } label: {
                                    if category.favorites.contains(where: {
                                        $0.unitSymbol
                                            == filteredUnits[index].symbol
                                    }) {
                                        Label(
                                            "Remove Favorite",
                                            systemImage: "minus.circle"
                                        )
                                        .tint(.red)
                                    } else {
                                        Label(
                                            "Add Favorite",
                                            systemImage: "plus.circle"
                                        )
                                        .tint(.green)
                                    }
                                }
                            }
                        }
                        .onChange(of: unitsSortedAscending) {
                            withAnimation(.easeInOut) {
                                sortAllUnits()
                            }
                        }
                        .onChange(of: category.favorites) {
                            sortFavorites()
                        }
                    }
                    header: {
                        HStack{
                            Text("All Units")
                                .font(.title2)
                                .bold()
                            
                            Spacer()
                            
                            Button("Search All Units", systemImage: "magnifyingglass.circle.fill") {
                                searchIsActive = true
                            }
                            .labelStyle(.iconOnly)
                        }
                    }
                }
            }
            .searchable(
                text: $searchText,
                isPresented: $searchIsActive,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "Search from all Units"
            )
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(
                        "Search All Units",
                        systemImage:
                            "magnifyingglass.circle.fill"
                    ) {
                        searchIsActive = true
                    }
                    .labelStyle(.iconOnly)
                    
                    SortButtonView(sortedAscending: $unitsSortedAscending)
                    
                    Button(allUnitsShowing ? "Hide All" : "Show All") {
                        allUnitsShowing.toggle()
                    }
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    if valueIsFocused {
                        Button("Done") {
                            valueIsFocused = false
                        }
                    }
                }
            }
            .sheet(isPresented: $sheetIsShowing) {
                AddUnitSheetView(category: category, allUnits: allUnits)
            }
            .navigationTitle("Convert \(title)")
        }
        .onAppear {
            sortedFavorites = favorites
            sortFavorites()
            sortAllUnits()
        }
    }
}
