//
//  ElectricResistanceView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 18.02.25.
//

import SwiftUI

struct ElectricResistanceView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitElectricResistance.ohms
    @State private var startValue = 1.0
    @State private var targetUnits = allElectricResistanceUnits
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $startValue, targetUnits: $targetUnits, allUnits: allElectricResistanceUnits, textFieldName: "Electric Resistance", standardUnit: .kiloohms, title: "Electric Resistance")
    }
}

