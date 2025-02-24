//
//  AngleView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 17.02.25.
//

import SwiftUI

struct AngleView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitAngle.degrees
    @State private var startValue = 90.0
    @State private var targetUnits = allAngleUnits
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $startValue, targetUnits: $targetUnits, allUnits: allAngleUnits, textFieldName: "Angle", standardUnit: .radians, title: "Angle")
    }
}
