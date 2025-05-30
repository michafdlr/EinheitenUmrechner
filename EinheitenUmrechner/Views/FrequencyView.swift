//
//  FrequencyView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 18.02.25.
//

import SwiftUI

struct FrequencyView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitFrequency.hertz
    @State private var startValue = 1.0
    @State private var targetUnits = allFrequencyUnits
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $startValue, sortedUnits: $targetUnits, allUnits: allFrequencyUnits, textFieldName: "Frequency", standardUnit: .kilohertz, title: "Frequency")
    }
}
