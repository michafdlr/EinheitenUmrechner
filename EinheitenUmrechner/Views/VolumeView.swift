//
//  VolumeView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 15.02.25.
//

import SwiftUI

struct VolumeView: View {

    @FocusState private var valueIsFocused
    @State private var startUnit = UnitVolume.cubicMeters
    @State private var volumeValue = 1.0
    @State private var targetUnits: [UnitVolume] = [UnitVolume.cubicDecimeters]

    
    var body: some View {
        
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $volumeValue, targetUnits: $targetUnits, allUnits: allVolumeUnits, textFieldName: "Volume", standardUnit: .liters, title: "Volume")
//        NavigationStack {
//            Form {
//                Section("Start Value") {
//                    StartValueView(textFieldName: "Volume", textInputWidth: textInputWidth, valueIsFocused: $valueIsFocused, inputValue: $volumeValue, startUnit: $startUnit, allUnits: allVolumeUnits)
//                }
//
//                Section("Target Units") {
//                    ForEach(targetUnits.indices, id: \.self) { index in
//                        TargetUnitView(
//                            targetValue: getTargetValue(targetUnit: targetUnits[index], measure: volumeMeasure),
//                            textInputWidth: textInputWidth,
//                            targetUnit: $targetUnits[index],
//                            allUnits: allVolumeUnits
//                        )
//                    }
//                }
//            }
//            .toolbar {
//                    Button("Add Target Unit", systemImage: "plus") {
//                        targetUnits.append(.cubicMeters)
//                    }
//                    if valueIsFocused {
//                        Button("Done") {
//                            valueIsFocused = false
//                        }
//                    }
//            }
//            .navigationTitle("Convert Volume")
//        }
    }
}

//private extension VolumeView {
//    var textInputWidth: CGFloat {
//        UIScreen.main.bounds.width * 0.5
//    }
//    
//    var volumeMeasure: Measurement<UnitVolume> {
//        Measurement(value: volumeValue, unit: startUnit)
//    }
//    
//}

//#Preview {
//    VolumeView()
//}
