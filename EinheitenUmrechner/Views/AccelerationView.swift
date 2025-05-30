//
//  AccelerationView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 18.02.25.
//

import SwiftUI

struct AccelerationView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitAcceleration.metersPerSecondSquared
    @State private var startValue = 1.0
    @State private var targetUnits = allAccelerationUnits
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $startValue, sortedUnits: $targetUnits, allUnits: allAccelerationUnits, textFieldName: "Acceleration", standardUnit: .gravity, title: "Acceleration")
    }
}
