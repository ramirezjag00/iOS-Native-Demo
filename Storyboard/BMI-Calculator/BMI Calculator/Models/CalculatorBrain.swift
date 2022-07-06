//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Andrey Ramirez on 6/25/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct CalculatorBrain {
    var bmi: BMI?

    func round2DecimalPlaces(_ value: Float) -> String {
        return String(format: "%.2f", value)
    }
    
    func unitRemoval(_ value: String) -> Float {
        return Float(value.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted))!
    }
    
    mutating func calculateBMI(_ height: String, _ weight: String) {
        let currentHeight = unitRemoval(height)
        let currentWeight = unitRemoval(weight)
        let calculatedBMI = round2DecimalPlaces(currentWeight / powf(currentHeight, 2))
        
        switch true {
        case (Float(calculatedBMI)! < 18.5):
            bmi = BMI(b: calculatedBMI, cat: "Underweight", catCol: UIColor.cyan)
        case (Float(calculatedBMI)! >= 18.5 && Float(calculatedBMI)! < 25):
            bmi = BMI(b: calculatedBMI, cat: "Normal weight", catCol: UIColor.blue)
        case (Float(calculatedBMI)! >= 25 && Float(calculatedBMI)! < 30):
            bmi = BMI(b: calculatedBMI, cat: "Overweight", catCol: UIColor.magenta)
        case (Float(calculatedBMI)! >= 30):
            bmi = BMI(b: calculatedBMI, cat: "Obesity", catCol: UIColor.red)
        default:
            bmi = BMI(b: calculatedBMI, cat: "Error", catCol: UIColor.black)
        }
    }
    
    func getResult(_ index: Int) -> Any {
        switch index {
        case 0:
            return bmi?.bmiValue ?? "0.0"
        case 1:
            return bmi?.category ?? "Error"
        case 2:
            return bmi?.categoryColor ?? UIColor.black
        default:
            return ""
        }
    }
    
    mutating func reset() {
        bmi?.bmiValue = nil
        bmi?.category = nil
        bmi?.categoryColor = nil
    }
}
