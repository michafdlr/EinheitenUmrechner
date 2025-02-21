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
    @State private var startValue = 10.0
    @State private var targetUnits: [UnitAcceleration] = [.gravity]
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $startValue, targetUnits: $targetUnits, allUnits: allAccelerationUnits, textFieldName: "Acceleration", standardUnit: .gravity, title: "Acceleration")
    }
}
