//
//  StorageView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 18.02.25.
//

import SwiftUI

struct StorageView: View {
    @FocusState private var valueIsFocused
    @State private var startUnit = UnitInformationStorage.gigabytes
    @State private var startValue = 1.0
    @State private var targetUnits = allInformationStorageUnits
    
    var body: some View {
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $startValue, sortedUnits: $targetUnits, allUnits: allInformationStorageUnits, textFieldName: "Information Storage", standardUnit: .bytes, title: "Information Storage")
    }
}

