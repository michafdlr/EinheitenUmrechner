//
//  PowerView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 18.02.25.
//

import SwiftUI

struct PowerView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitPower.watts
    @State private var startValue = 1.0
    @State private var targetUnits = allPowerUnits
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $startValue, targetUnits: $targetUnits, allUnits: allPowerUnits, textFieldName: "Power", standardUnit: .horsepower, title: "Power")
    }
}

