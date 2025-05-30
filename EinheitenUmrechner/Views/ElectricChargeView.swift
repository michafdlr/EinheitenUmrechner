//
//  ElectricChargeView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 18.02.25.
//

import SwiftUI

struct ElectricChargeView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitElectricCharge.coulombs
    @State private var startValue = 1.0
    @State private var targetUnits = allElectricChargeUnits
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $startValue, sortedUnits: $targetUnits, allUnits: allElectricChargeUnits, textFieldName: "Electric Charge", standardUnit: .ampereHours, title: "Electric Charge")
    }
}
