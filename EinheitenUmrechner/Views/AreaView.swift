//
//  AreaView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 14.02.25.
//

import SwiftUI

struct AreaView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitArea.squareMeters
    @State private var areaValue = 1.0
    @State private var targetUnits: [UnitArea] = [UnitArea.squareCentimeters]
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $areaValue, targetUnits: $targetUnits, allUnits: allAreaUnits, textFieldName: "Area", standardUnit: .squareMeters, title: "Area")
    }
}

//struct AreaView: View {
//    @FocusState private var valueIsFocused
//    @State private var startUnit = UnitArea.squareMeters
//    @State private var areaValue = 1.0
//    @State private var targetUnits: [UnitArea] = [UnitArea.squareCentimeters]
//
//    var body: some View {
//        NavigationStack {
//            Form {
//                Section("Start Value") {
//                    StartValueView(
//                        textFieldName: "Area", textInputWidth: textInputWidth,
//                        valueIsFocused: $valueIsFocused, inputValue: $areaValue,
//                        startUnit: $startUnit, allUnits: allAreaUnits)
//                }
//
//                Section("Target Units") {
//                    ForEach(targetUnits.indices, id: \.self) { index in
//                        TargetUnitView(
//                            targetValue: getTargetValue(
//                                targetUnit: targetUnits[index],
//                                measure: areaMeasure),
//                            textInputWidth: textInputWidth,
//                            targetUnit: $targetUnits[index],
//                            allUnits: allAreaUnits
//                        )
//                    }
//
//                }
//            }
//            .toolbar {
//                Button("Add Target Unit", systemImage: "plus") {
//                    targetUnits.append(.squareMeters)
//                }
//                if valueIsFocused {
//                    Button("Done") {
//                        valueIsFocused = false
//                    }
//                }
//            }
//            .navigationTitle("Convert Area")
//        }
//    }
//}
//
//private extension AreaView {
//    var textInputWidth: CGFloat {
//        UIScreen.main.bounds.width * 0.5
//    }
//
//    var areaMeasure: Measurement<UnitArea> {
//        Measurement(value: areaValue, unit: startUnit)
//    }
//}
