//
//  LengthView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 09.02.25.
//

import SwiftUI

struct LengthView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitLength.meters
    @State private var lengthValue = 1.0
    @State private var targetUnits: [UnitLength] = [UnitLength.centimeters]
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $lengthValue, targetUnits: $targetUnits, allUnits: allLengthUnits, textFieldName: "Length", standardUnit: .meters, title: "Length")
    }
}

//struct LengthView: View {
//
//    @FocusState private var valueIsFocused
//    @State private var startUnit = UnitLength.meters
//    @State private var lengthValue = 1.0
//    @State private var targetUnits: [UnitLength] = [UnitLength.centimeters]
//
//    
//    var body: some View {
//        NavigationStack {
//            Form {
//                Section("Start Value") {
//                    StartValueView(textFieldName: "Length", textInputWidth: textInputWidth, valueIsFocused: $valueIsFocused, inputValue: $lengthValue, startUnit: $startUnit, allUnits: allLengthUnits)
//                }
//
//                Section("Target Units") {
//                    ForEach(targetUnits.indices, id: \.self) { index in
//                        TargetUnitView(
//                            targetValue: getTargetValue(targetUnit: targetUnits[index], measure: lengthMeasure),
//                            textInputWidth: textInputWidth,
//                            targetUnit: $targetUnits[index],
//                            allUnits: allLengthUnits
//                        )
//                    }
//                }
//            }
//            .toolbar {
//                    Button("Add Target Unit", systemImage: "plus") {
//                        targetUnits.append(.meters)
//                    }
//                    if valueIsFocused {
//                        Button("Done") {
//                            valueIsFocused = false
//                        }
//                    }
//            }
//            .navigationTitle("Convert Length")
//        }
//    }
//}
//
//private extension LengthView {
//    var textInputWidth: CGFloat {
//        UIScreen.main.bounds.width * 0.5
//    }
//    
//    var lengthMeasure: Measurement<UnitLength> {
//        Measurement(value: lengthValue, unit: startUnit)
//    }
//}
//
//#Preview {
//    LengthView()
//}
