//
//  FuelEfficiencyView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 18.02.25.
//

import SwiftUI

struct FuelEfficiencyView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitFuelEfficiency.litersPer100Kilometers
    @State private var startValue = 1.0
    @State private var targetUnits = allFuelEfficiencyUnits
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $startValue, targetUnits: $targetUnits, allUnits: allFuelEfficiencyUnits, textFieldName: "Fuel Efficiency", standardUnit: .milesPerGallon, title: "Fuel Efficiency")
    }
}
