//
//  CategoryView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 16.02.25.
//

import SwiftUI

struct CategoryView<T: Dimension>: View {    
    @FocusState.Binding var valueIsFocused: Bool
    @Binding var startUnit: T
    @Binding var startValue: Double
    @Binding var targetUnits: [T]
    
    let allUnits: [T]
    let textFieldName: String
    let standardUnit: T
    let title: LocalizedStringResource
    

    @State private var allUnitsShowing = true
    @State private var searchText = ""
    @State private var sheetIsShowing = false
    @State private var unitsSortedAscending = true

    var textInputWidth: CGFloat {
        UIScreen.main.bounds.width * 0.5
    }

    var valueMeasure: Measurement<T> {
        Measurement(value: startValue, unit: startUnit)
    }
    
    
    func sortTargetUnits() {
        if unitsSortedAscending {
            targetUnits = targetUnits.sorted {
                measureFormatter.string(from: $0).localizedLowercase <= measureFormatter.string(from: $1).localizedLowercase
            }
        } else {
            targetUnits = targetUnits.sorted {
                measureFormatter.string(from: $0).localizedLowercase > measureFormatter.string(from: $1).localizedLowercase
            }
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Base Value") {
                    StartValueView(
                        textFieldName: textFieldName,
                        textInputWidth: textInputWidth,
                        valueIsFocused: $valueIsFocused,
                        inputValue: $startValue,
                        startUnit: $startUnit,
                        allUnits: allUnits)
                }

                Section("Target Units") {
                    ForEach(targetUnits.indices, id: \.self) { index in
                        TargetUnitView(
                            targetValue: getTargetValue(
                                targetUnit: targetUnits[index],
                                measure: valueMeasure),
                            textInputWidth: textInputWidth * 2,
                            targetUnit: $targetUnits[index],
                            allUnits: allUnits
                        )
                    }
                    .onDelete { index in
                        targetUnits.remove(atOffsets: index)
                        allUnitsShowing = false
                    }
                    .onChange(of: unitsSortedAscending) {
                        withAnimation(.easeInOut) {
                            sortTargetUnits()
                        }
                    }
                    .onChange(of: targetUnits) {
                        sortTargetUnits()
                    }
                    
                }
            }
            .toolbar {
                Button(allUnitsShowing ? "Hide All" : "Show All") {
                    targetUnits = allUnitsShowing ? [] : allUnits
                    allUnitsShowing.toggle()
                }
                
                SortButtonView(sortedAscending: $unitsSortedAscending)
                
                if !allUnitsShowing {
                    Button("Add Target Unit", systemImage: "plus") {
                        sheetIsShowing.toggle()
                    }
                    .sheet(isPresented: $sheetIsShowing) {
                        AddUnitSheetView(targetUnits: $targetUnits, allUnits: allUnits)
                    }
                }
                if valueIsFocused {
                    Button("Done") {
                        valueIsFocused = false
                    }
                }
            }
            .navigationTitle("Convert \(title)")
        }
        .onAppear(perform: sortTargetUnits)
    }
}
