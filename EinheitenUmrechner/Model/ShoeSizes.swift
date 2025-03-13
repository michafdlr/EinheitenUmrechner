//
//  ShoeSizes.swift
//  EinheitenUmrechner
//
//  Created by Michael Fiedler on 12.03.25.
//

import Foundation

/// Custom converter that maps shoe sizes via a lookup table
class UnitConverterShoeSize: UnitConverter {
    /// Lookup table for shoe size conversions
    private let conversionTable: [String: [Double]] = [
            "EU":  [35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50],
            "USM": [3.0, 4.0, 5.0, 6.0, 7.0, 7.5, 8.0, 9.0, 10.0, 10.5, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0],
            "USW": [5.0, 6.0, 7.0, 8.0, 9.0, 9.5, 10.0, 11.0, 12.0, 12.5, 13.0, 14.0, 15.0, 16.0, 17.0, 18.0],
            "UK":  [2.5, 3.5, 4.5, 5.5, 6.5, 7.0, 7.5, 8.5, 9.5, 10.0, 10.5, 11.5, 12.5, 13.5, 14.5, 15.5]
        ]
    
    /// Converts from any shoe size unit to **EU size** (base unit)
    override func baseUnitValue(fromValue value: Double) -> Double {
        return convert(value, from: currentUnit, to: "EU") // Convert to EU
    }
    
    /// Converts from **EU size** to the target unit
    override func value(fromBaseUnitValue baseValue: Double) -> Double {
        return convert(baseValue, from: "EU", to: currentUnit) // Convert from EU
    }
    
    /// Tracks the current unit (needed for proper conversion)
    private var currentUnit: String
    
    /// Initializer to set the current unit
    init(currentUnit: String) {
        self.currentUnit = currentUnit
    }
    
    /// Converts shoe sizes using lookup tables
    private func convert(_ value: Double, from fromUnit: String, to toUnit: String) -> Double {
        guard let fromSizes = conversionTable[fromUnit], let toSizes = conversionTable[toUnit] else {
            return value // No conversion possible
        }
        
        // Find the closest match using interpolation
        if let lowerIndex = fromSizes.lastIndex(where: { $0 <= value }),
           let upperIndex = fromSizes.firstIndex(where: { $0 >= value }) {
            
            // If exact match, return corresponding size
            if lowerIndex == upperIndex, toSizes.indices.contains(lowerIndex) {
                return toSizes[lowerIndex]
            }
            
            // Linear interpolation for in-between values
            if lowerIndex < upperIndex, toSizes.indices.contains(lowerIndex), toSizes.indices.contains(upperIndex) {
                let fromLower = fromSizes[lowerIndex]
                let fromUpper = fromSizes[upperIndex]
                let toLower = toSizes[lowerIndex]
                let toUpper = toSizes[upperIndex]
                
                let ratio = (value - fromLower) / (fromUpper - fromLower)
                return toLower + ratio * (toUpper - toLower)
            }
        }
        
        // If size is out of range, return the closest available size
        return value < fromSizes.first! ? toSizes.first! : toSizes.last!
    }
}

/// Shoe size unit class with predefined units
final class UnitShoeSize: Dimension {
    static let eu = UnitShoeSize(symbol: "EU", converter: UnitConverterShoeSize(currentUnit: "EU"))
    static let usMen = UnitShoeSize(symbol: "USM", converter: UnitConverterShoeSize(currentUnit: "USM"))
    static let usWomen = UnitShoeSize(symbol: "USW", converter: UnitConverterShoeSize(currentUnit: "USW"))
    static let uk = UnitShoeSize(symbol: "UK", converter: UnitConverterShoeSize(currentUnit: "UK"))

    override class func baseUnit() -> UnitShoeSize {
        return .eu // Base size is EU
    }
}
