//
//  PressureView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 18.02.25.
//

import SwiftUI

struct PressureView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitPressure.bars
    @State private var startValue = 1.0
    @State private var targetUnits: [UnitPressure] = [.kilopascals]
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $startValue, targetUnits: $targetUnits, allUnits: allPressureUnits, textFieldName: "Pressure", standardUnit: .kilopascals, title: "Pressure")
    }
}

