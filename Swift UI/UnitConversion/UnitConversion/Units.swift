//
//  Units.swift
//  UnitConversion
//
//  Created by Andrey Ramirez on 7/15/22.
//

import Foundation

struct K {
    enum TypeCases: String, CaseIterable {
        case Temperature = "Temp"
        case Length = "Length"
        case Time = "Time"
        case Volume = "Volume"
        case Mass = "Mass"
    }
    
    static let tempUnits: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    static let lengthUnits: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
    static let timeUnits: [UnitDuration] = [.seconds, .minutes, .hours]
    static let volumeUnits: [UnitVolume] = [.milliliters, .liters, .cups, .pints, .fluidOunces, .gallons]
    static let massUnits: [UnitMass] = [.grams, .kilograms, .pounds, .metricTons]
    
    static let typesArray: [TypeCases] = []
    
    static let types: [TypeCases: [Unit]] = [
        .Temperature: tempUnits,
        .Length: lengthUnits,
        .Time: timeUnits,
        .Volume: volumeUnits,
        .Mass: massUnits,
    ]
    static let defaultUnits = (typeUnit: TypeCases.Temperature.rawValue, fromUnit: types[(TypeCases.Temperature)]![0], toUnit: types[(TypeCases.Temperature)]![1])
}
