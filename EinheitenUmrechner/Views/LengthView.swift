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
    @State private var targetUnit = UnitLength.centimeters
    @State private var lengthValue = 1.0

    var lengthMeasure: Measurement<UnitLength> {
        Measurement(value: lengthValue, unit: startUnit)
    }

    var targetLength: Measurement<UnitLength> {
        lengthMeasure.converted(to: targetUnit)
    }
    var body: some View {
        NavigationStack {
            Form {
                Section("Startwert") {
                    HStack {
                        HStack {
                            TextField("Länge", value: $lengthValue, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .frame(width: 125)
                                .keyboardType(.decimalPad)
                                .focused($valueIsFocused)
                            
                            Text(formatter.string(from: startUnit))
                        }
                        .frame(width: 250)
                        
                        Divider()
                        
                        NavigationLink("Einheiten") {
                            UnitsView(selected: $startUnit)
                        }
//                        Picker("Einheit", selection: $startUnit) {
//                            ForEach(allUnits, id: \.self) { unit in
//                                    Text(formatter.string(from: unit))
//                                
//                            }
//                        }
//                        .pickerStyle(.navigationLink)
                    }
                }

                Section("Zieleinheit") {
                    HStack {
                        
                        Text(
                            "\(targetLength.value, specifier: "%.2f") \(formatter.string(from: targetUnit))"
                        )
                        .bold()
                        .frame(width: 250)
                        
                        
                        Divider()
                        
                        NavigationLink("Einheiten") {
                            UnitsView(selected: $targetUnit)
                        }
                    }
//                    Picker("Zieleinheit", selection: $targetUnit) {
//                        ForEach(allUnits, id: \.self) { unit in
//                            Text(unit.symbol)
//                        }
//                    }
                }
            }
            .toolbar {
                if valueIsFocused {
                    Button("Fertig") {
                        valueIsFocused = false
                    }
                }
            }
            .navigationTitle("Längenumrechnung")
        }
    }
}

#Preview {
    LengthView()
}
