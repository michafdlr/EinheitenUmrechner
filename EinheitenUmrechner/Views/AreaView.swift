//
//  AreaView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 14.02.25.
//

import SwiftUI

struct AreaView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitArea.squareMeters
    @State private var startValue = 1.0
    @State private var targetUnits: [UnitArea] = [UnitArea.squareCentimeters]
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $startValue, targetUnits: $targetUnits, allUnits: allAreaUnits, textFieldName: "Area", standardUnit: .squareMeters, title: "Area")
    }
}
