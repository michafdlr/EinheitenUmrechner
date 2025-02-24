//
//  DurationView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 17.02.25.
//

import SwiftUI

struct DurationView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitDuration.hours
    @State private var areaValue = 1.0
    @State private var targetUnits = allDurationUnits
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $areaValue, targetUnits: $targetUnits, allUnits: allDurationUnits, textFieldName: "Time", standardUnit: .minutes, title: "Time")
    }
}
