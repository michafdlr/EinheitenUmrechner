//
//  Units.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 10.02.25.
//

import Foundation

extension UnitArea {
    static let squareDecimeters = UnitArea(symbol: "dm²", converter: UnitConverterLinear(coefficient: 0.01))
}

let allLengthUnits: [UnitLength] = [
    .megameters, .kilometers, .hectometers, .decameters, .meters,
    .decimeters, .centimeters, .millimeters, .micrometers, .nanometers,
    .picometers, .inches, .feet, .yards, .miles, .scandinavianMiles,
    .lightyears, .nauticalMiles, .fathoms, .furlongs, .astronomicalUnits,
    .parsecs,
]

let allAreaUnits: [UnitArea] = [
    .squareMegameters, .squareKilometers, .squareMeters, .squareCentimeters,
    .squareMillimeters, .squareDecimeters,
    .squareMicrometers, .squareNanometers, .squareInches, .squareFeet,
    .squareYards, .squareMiles,
    .acres, .hectares,
]

let allVolumeUnits: [UnitVolume] = [
    .megaliters, .kiloliters, .liters, .deciliters, .centiliters, .milliliters,
    .cubicKilometers, .cubicMeters, .cubicDecimeters, .cubicCentimeters,
    .cubicMillimeters,
    .cubicInches, .cubicFeet, .cubicYards, .cubicMiles, .acreFeet, .bushels,
    .teaspoons,
    .tablespoons, .fluidOunces, .cups, .pints, .quarts, .gallons,
    .imperialTeaspoons,
    .imperialTablespoons, .imperialFluidOunces, .imperialPints, .imperialQuarts,
    .imperialGallons,
]

let allTemperatureUnits: [UnitTemperature] = [
    .kelvin, .celsius, .fahrenheit,
]

let allMassUnits: [UnitMass] = [
    .kilograms, .grams, .decigrams, .centigrams, .milligrams, .micrograms,
    .nanograms,
    .metricTons, .stones, .pounds, .ounces, .carats, .slugs,
]

let allAngleUnits: [UnitAngle] = [
    .degrees, .arcMinutes, .arcSeconds, .radians, .gradians, .revolutions,
]

let allAccelerationUnits: [UnitAcceleration] = [
    .metersPerSecondSquared, .gravity,
]

let allChargeUnits: [UnitElectricCharge] = [
    .coulombs, .megaampereHours, .kiloampereHours, .ampereHours,
    .milliampereHours, .microampereHours,
]

let allEnergyUnits: [UnitEnergy] = [
    .joules, .kilojoules, .calories, .kilocalories, .kilowattHours,
]

let allFrequencyUnits: [UnitFrequency] = [
    .hertz, .kilohertz, .megahertz, .gigahertz, .terahertz, .framesPerSecond,
    .microhertz, .millihertz, .nanohertz,
]

let allFuelEfficiencyUnits: [UnitFuelEfficiency] = [
    .litersPer100Kilometers, .milesPerGallon,
]

let allPowerUnits: [UnitPower] = [
    .watts, .kilowatts, .gigawatts, .terawatts, .horsepower,
    .femtowatts, .megawatts, .microwatts, .milliwatts, .nanowatts, .picowatts,
]

let allPressureUnits: [UnitPressure] = [
    .gigapascals, .megapascals, .kilopascals, .hectopascals, .inchesOfMercury,
    .bars, .millibars, .millimetersOfMercury, .poundsForcePerSquareInch,
    .newtonsPerMetersSquared,
]

let allSpeedUnits: [UnitSpeed] = [
    .metersPerSecond, .kilometersPerHour, .milesPerHour, .knots,
]

let allDurationUnits: [UnitDuration] = [
    .seconds, .minutes, .hours, .microseconds, .milliseconds, .nanoseconds,
    .picoseconds,
]

let allElectricCurrentUnits: [UnitElectricCurrent] = [
    .amperes, .kiloamperes, .megaamperes, .microamperes, .milliamperes
]

let allElectricResistanceUnits: [UnitElectricResistance] = [
    .kiloohms, .megaohms, .microohms, .milliohms, .ohms
]

let allInformationStorageUnits: [UnitInformationStorage] = [
    .bits, .bytes, .exabits, .exabytes, .exbibits, .exbibytes, .gibibits, .gibibytes, .gigabits, .gigabytes, .kibibits, .kibibytes, .kilobits, .kilobytes, .mebibits, .mebibytes, .megabits, .megabytes, .nibbles, .pebibits, .pebibytes, .petabits, .petabytes, .tebibits, .tebibytes, .terabits, .terabytes, .yobibits, .yobibytes, .yottabits, .yottabytes, .zebibits, .zebibytes, .zettabits, .zettabytes
]

let allElectricPotentialDifferenceUnits: [UnitElectricPotentialDifference] = [
    .kilovolts, .megavolts, .microvolts, .millivolts, .volts
]

let allElectricChargeUnits: [UnitElectricCharge] = [
    .ampereHours, .coulombs, .kiloampereHours, .megaampereHours, .microampereHours, .milliampereHours
]

let allShoeSizes: [UnitShoeSize] = [
    .eu, .uk, .usMen, .usWomen
]


func getUnit(from symbol: String) -> Dimension? {        
    let unitArrays: [[Dimension]] = [
        allAreaUnits, allMassUnits, allAngleUnits, allPowerUnits, allSpeedUnits,allChargeUnits, allEnergyUnits, allLengthUnits, allVolumeUnits, allDurationUnits,
        allPressureUnits, allFrequencyUnits, allTemperatureUnits, allAccelerationUnits,
        allElectricChargeUnits, allFuelEfficiencyUnits, allElectricCurrentUnits,
        allElectricResistanceUnits, allInformationStorageUnits, allElectricPotentialDifferenceUnits, allShoeSizes
    ]

    let allUnits = unitArrays.reduce([], +)
    
    return allUnits.first { $0.symbol == symbol }
}


var measureFormatter: MeasurementFormatter {
    let formatter = MeasurementFormatter()
    formatter.unitStyle = .long
    return formatter
}

func getTargetValue<T: Dimension>(targetUnit: T, measure: Measurement<T>)
    -> Measurement<T>
{
    return measure.converted(to: targetUnit)
}
