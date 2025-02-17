//
//  Units.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 10.02.25.
//

import Foundation

let allLengthUnits: [UnitLength] = [
    .megameters, .kilometers, .hectometers, .decameters, .meters,
    .decimeters, .centimeters, .millimeters, .micrometers, .nanometers,
    .picometers, .inches, .feet, .yards, .miles, .scandinavianMiles,
    .lightyears, .nauticalMiles, .fathoms, .furlongs, .astronomicalUnits,
    .parsecs,
]

let allAreaUnits: [UnitArea] = [
    .squareMegameters, .squareKilometers, .squareMeters, .squareCentimeters, .squareMillimeters,
    .squareMicrometers, .squareNanometers, .squareInches, .squareFeet, .squareYards, .squareMiles,
    .acres, .hectares
]

let allVolumeUnits: [UnitVolume] = [
        .megaliters, .kiloliters, .liters, .deciliters, .centiliters, .milliliters,
        .cubicKilometers, .cubicMeters, .cubicDecimeters, .cubicCentimeters, .cubicMillimeters,
        .cubicInches, .cubicFeet, .cubicYards, .cubicMiles, .acreFeet, .bushels, .teaspoons,
        .tablespoons, .fluidOunces, .cups, .pints, .quarts, .gallons, .imperialTeaspoons,
        .imperialTablespoons, .imperialFluidOunces, .imperialPints, .imperialQuarts,
        .imperialGallons
    ]

let allTemperatureUnits: [UnitTemperature] = [
    .kelvin, .celsius, .fahrenheit
]

let allMassUnits: [UnitMass] = [
    .kilograms, .grams, .decigrams, .centigrams, .milligrams, .micrograms, .nanograms,
    .metricTons, .stones, .pounds, .ounces, .carats, .slugs
]

var measureFormatter: MeasurementFormatter {
    let formatter = MeasurementFormatter()
    formatter.unitStyle = .long
    return formatter
}

func getTargetValue<T: Dimension>(targetUnit: T, measure: Measurement<T>) -> Measurement<T> {
    return measure.converted(to: targetUnit)
}
