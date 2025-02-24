//
//  SpeedView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 18.02.25.
//

import SwiftUI

struct SpeedView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitSpeed.kilometersPerHour
    @State private var startValue = 1.0
    @State private var targetUnits = allSpeedUnits
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $startValue, targetUnits: $targetUnits, allUnits: allSpeedUnits, textFieldName: "Speed", standardUnit: .metersPerSecond, title: "Speed")
    }
}

