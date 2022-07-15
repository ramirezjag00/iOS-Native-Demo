//
//  ContentView.swift
//  UnitConversion
//
//  Created by Andrey Ramirez on 7/15/22.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State private var number: Double?
    @State private var fromUnit = K.defaultUnits.fromUnit as! Dimension
    @State private var toUnit = K.defaultUnits.toUnit as! Dimension
    @State private var typeUnit: String = K.defaultUnits.typeUnit
    @FocusState private var numberIsFocused: Bool
    let formatter: MeasurementFormatter
    
    func setDefaultUnits(_ newType: String) {
        if let safeMeasurementUnitType = K.TypeCases(rawValue: newType) {
            if let safeUnits = K.types[safeMeasurementUnitType] {
                fromUnit = safeUnits[0] as! Dimension
                toUnit = safeUnits[1] as! Dimension
            }
        }
    }
    
    var unitOptions: [Dimension] {
        if let safeMeasurementUnitType = K.TypeCases(rawValue: typeUnit) {
            if let safeUnits = K.types[safeMeasurementUnitType] {
                return safeUnits as! [Dimension]
            }
        }

        return []
    }
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
    
    var convertedNumber: String {
        if let safeNumber = number {
            let input = Measurement(value: safeNumber, unit: fromUnit)
            let output = input.converted(to: toUnit)
            return formatter.string(from: output)
        }
        
        return ""
    }

    var body: some View {
        Form {
            Section (header: Text("Unit Conversion")) {
                Picker("Unit Conversion", selection: $typeUnit) {
                    ForEach(K.TypeCases.allCases.map { $0.rawValue }, id: \.self) {
                        Text("\($0)")
                    }
                }.pickerStyle(.segmented)
            }

            Section (header: Text("From")) {
                TextField("Number", value: $number, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($numberIsFocused)
                Picker("Unit Conversion", selection: $fromUnit) {
                    ForEach(unitOptions, id: \.self) {
                        Text("\($0.symbol)")
                    }
                }.pickerStyle(.segmented)
            }
            
            Section (header: Text("To")) {
                Text(convertedNumber)
                Picker("Unit Conversion", selection: $toUnit) {
                    ForEach(unitOptions, id: \.self) {
                        Text("\($0.symbol)")
                    }
                }.pickerStyle(.segmented)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()

                Button("Done") {
                    numberIsFocused = false
                }
            }
        }
        .onChange(of: typeUnit) { newType in
            setDefaultUnits(newType)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
