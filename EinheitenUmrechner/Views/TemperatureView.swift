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
    }
}
