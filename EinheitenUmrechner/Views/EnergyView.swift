//
//  EnergyView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 18.02.25.
//

import SwiftUI

struct EnergyView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitEnergy.kilocalories
    @State private var startValue = 100.0
    @State private var targetUnits = allEnergyUnits
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $startValue, targetUnits: $targetUnits, allUnits: allEnergyUnits, textFieldName: "Energy", standardUnit: .kilojoules, title: "Energy")
    }
}
