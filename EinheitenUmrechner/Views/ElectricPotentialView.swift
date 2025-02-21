//
//  ElectricPotentialView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 18.02.25.
//

import SwiftUI

struct ElectricPotentialView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitElectricPotentialDifference.volts
    @State private var startValue = 1.0
    @State private var targetUnits: [UnitElectricPotentialDifference] = [.kilovolts]
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $startValue, targetUnits: $targetUnits, allUnits: allElectricPotentialDifferenceUnits, textFieldName: "Electric Potential", standardUnit: .kilovolts, title: "Electric Potential")
    }
}

