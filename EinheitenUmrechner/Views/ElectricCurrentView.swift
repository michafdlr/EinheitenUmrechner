//
//  ElectricCurrentView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 17.02.25.
//

import SwiftUI

struct ElectricCurrentView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitElectricCurrent.amperes
    @State private var startValue = 1.0
    @State private var targetUnits = allElectricCurrentUnits
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $startValue, sortedUnits: $targetUnits, allUnits: allElectricCurrentUnits, textFieldName: "Electric Current", standardUnit: .milliamperes, title: "Electric Current")
    }
}
