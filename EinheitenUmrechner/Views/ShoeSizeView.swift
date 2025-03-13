//
//  ShoeSizeView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 12.03.25.
//

import SwiftUI

struct ShoeSizeView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitShoeSize.eu
    @State private var startValue = 35.0
    @State private var targetUnits = allShoeSizes
    
    var body: some View {
        VStack {
            CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $startValue, sortedUnits: $targetUnits, allUnits: allShoeSizes, textFieldName: "Shoe Size", standardUnit: .eu, title: "Shoe Size")
        }
    }
}
