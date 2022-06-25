//
//  CalculateBill.swift
//  Tipsy
//
//  Created by Andrey Ramirez on 6/26/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CalculateBill {
    var splitBill: Bill?

    func pctToFloat(_ value: String) -> Float {
        return Float(value.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted))! / 100
    }

    mutating func setTipValue(_ tipPct: String) {
        splitBill = Bill(b: nil, tip: pctToFloat(tipPct), s: nil, ts: nil)
    }
    
    mutating func setBill(bill: Float, split: Float) {
        let splitValue = bill / split
        let totalSplit = splitValue + (splitValue * (splitBill?.tipValue!)!)
        splitBill = Bill(b: bill, tip: splitBill?.tipValue, s: split, ts: totalSplit)
    }
    
    func getResult() -> (totalPerPerson: String, split: Int, tipPercentage: String) {
        (totalPerPerson: String(format: "%.2f", splitBill?.totalSplit! ?? 0.0),
         split: Int(splitBill?.split! ?? 2),
         tipPercentage: "\(String(format: "%.0f", (splitBill?.tipValue! ?? 0.1) * 100))%")
    }
    
    mutating func reset() {
        splitBill = Bill(b: nil, tip: nil, s: nil, ts: nil)
    }
}
