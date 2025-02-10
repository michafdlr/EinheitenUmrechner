//
//  Units.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 10.02.25.
//

import Foundation

let allUnits: [UnitLength] = [
    .megameters, .kilometers, .hectometers, .decameters, .meters,
    .decimeters, .centimeters, .millimeters, .micrometers, .nanometers,
    .picometers, .inches, .feet, .yards, .miles, .scandinavianMiles,
    .lightyears, .nauticalMiles, .fathoms, .furlongs, .astronomicalUnits,
    .parsecs,
]

var formatter: MeasurementFormatter {
    let formatter = MeasurementFormatter()
    formatter.unitStyle = .long
    return formatter
}
