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
    
    var textInputWidth: CGFloat {
        UIScreen.main.bounds.width * 0.5
    }

    var valueMeasure: Measurement<T> {
        Measurement(value: startValue, unit: startUnit)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Start Value") {
                    StartValueView(
                        textFieldName: textFieldName, textInputWidth: textInputWidth,
                        valueIsFocused: $valueIsFocused, inputValue: $startValue,
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
                Button("Add Target Unit", systemImage: "plus") {
                    targetUnits.append(standardUnit)
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
