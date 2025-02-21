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

    @State private var allUnitsShowing = false
    @State private var searchText = ""

//    var filteredTargetUnits: [T] {
//        if searchText.isEmpty {
//            return targetUnits
//        }
//        return targetUnits.filter {
//            measureFormatter.string(from: $0).localizedCaseInsensitiveContains(
//                searchText)
//                || $0.symbol.localizedCaseInsensitiveContains(searchText)
//        }
//    }

    var textInputWidth: CGFloat {
        UIScreen.main.bounds.width * 0.5
    }

    var valueMeasure: Measurement<T> {
        Measurement(value: startValue, unit: startUnit)
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
                        startUnit: $startUnit, allUnits: allUnits)
                }

                Section("Target Units") {
                    ForEach(targetUnits.indices, id: \.self) { index in
                        TargetUnitView(
                            targetValue: getTargetValue(
                                targetUnit: targetUnits[index],
                                measure: valueMeasure),
                            textInputWidth: textInputWidth,
                            targetUnit: $targetUnits[index],
                            allUnits: allUnits
                        )
                    }
                }
            }
            .toolbar {
                Button("Add One", systemImage: "plus") {
                    targetUnits.append(standardUnit)
                }

                Button(allUnitsShowing ? "Show One" : "Show All") {
                    targetUnits = allUnitsShowing ? [standardUnit] : allUnits
                    allUnitsShowing.toggle()
                }
                if valueIsFocused {
                    Button("Done") {
                        valueIsFocused = false
                    }
                }
            }
            .navigationTitle("Convert \(title)")
        }
    }
}
