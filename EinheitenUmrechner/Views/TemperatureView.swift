//
//  TemperatureView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 15.02.25.
//

import SwiftUI

struct TemperatureView: View {

    @FocusState private var valueIsFocused
    @State private var startUnit = UnitTemperature.celsius
    @State private var temperatureValue = 20.0
    @State private var targetUnits = [UnitTemperature.celsius]

    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $temperatureValue, targetUnits: $targetUnits, allUnits: allTemperatureUnits, textFieldName: "Temperature", standardUnit: .celsius, title: "Temperature")
        
//        NavigationStack {
//            Form {
//                Section("Start Value") {
//                    StartValueView(
//                        textFieldName: "Temperature",
//                        textInputWidth: textInputWidth,
//                        valueIsFocused: $valueIsFocused,
//                        inputValue: $temperatureValue, startUnit: $startUnit,
//                        allUnits: allTemperatureUnits)
//                }
//
//                Section("Target Units") {
//                    ForEach(allTemperatureUnits.indices, id: \.self) { index in
//                        Text(
//                            "\(getTargetValue(targetUnit: allTemperatureUnits[index], measure: temperatureMeasure).value) \(allTemperatureUnits[index].symbol)"
//                        )
//                        .multilineTextAlignment(.leading)
//                        .bold()
//                        .frame(
//                            minWidth: 0.5 * textInputWidth,
//                            alignment: .topLeading)
//                    }
//                }
//            }
//            .toolbar {
//                if valueIsFocused {
//                    Button("Done") {
//                        valueIsFocused = false
//                    }
//                }
//            }
//            .navigationTitle("Convert Temperature")
//        }
    }
}

//extension TemperatureView {
//    fileprivate var textInputWidth: CGFloat {
//        UIScreen.main.bounds.width * 0.5
//    }
//
//    fileprivate var temperatureMeasure: Measurement<UnitTemperature> {
//        Measurement(value: temperatureValue, unit: startUnit)
//    }
//}
