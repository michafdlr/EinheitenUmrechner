//
//  LengthView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 09.02.25.
//

import SwiftUI

struct LengthView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitLength.meters
    @State private var lengthValue = 1.0
    @State private var targetUnits: [UnitLength] = [UnitLength.centimeters]
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $lengthValue, targetUnits: $targetUnits, allUnits: allLengthUnits, textFieldName: "Length", standardUnit: .meters, title: "Length")
    }
}
