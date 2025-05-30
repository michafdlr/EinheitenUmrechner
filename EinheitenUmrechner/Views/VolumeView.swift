//
//  VolumeView.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 15.02.25.
//

import SwiftUI

struct VolumeView: View {

    @FocusState private var valueIsFocused
    @State private var startUnit = UnitVolume.cubicMeters
    @State private var volumeValue = 1.0
    @State private var targetUnits = allVolumeUnits

    
    var body: some View {
        
        CategoryView(valueIsFocused: $valueIsFocused, startUnit: $startUnit, startValue: $volumeValue, sortedUnits: $targetUnits, allUnits: allVolumeUnits, textFieldName: "Volume", standardUnit: .liters, title: "Volume")
    }
}
