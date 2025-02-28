//
//  MassView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 16.02.25.
//

import SwiftUI

struct MassView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitMass.kilograms
    @State private var startValue = 1.0
    @State private var targetUnits = allMassUnits
    
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $startValue, sortedUnits: $targetUnits, allUnits: allMassUnits, textFieldName: "Mass", standardUnit: .kilograms, title: "Mass")
    }
}
