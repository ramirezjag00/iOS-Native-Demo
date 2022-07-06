//
//  BMI.swift
//  BMI Calculator
//
//  Created by Andrey Ramirez on 6/25/22.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct BMI {
    var bmiValue: String? = nil
    var category: String? = nil
    var categoryColor: UIColor? = nil
    
    init(b: String, cat: String, catCol: UIColor) {
        self.bmiValue = b
        self.category = cat
        self.categoryColor = catCol
    }
}
