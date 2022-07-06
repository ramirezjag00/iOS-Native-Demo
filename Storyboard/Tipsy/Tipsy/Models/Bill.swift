//
//  Bill.swift
//  Tipsy
//
//  Created by Andrey Ramirez on 6/26/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct Bill {
    var bill: Float?
    var tipValue: Float?
    var split: Float?
    var totalSplit: Float?
    
    init(b: Float?, tip: Float?, s: Float?, ts: Float?) {
        self.bill = b
        self.tipValue = tip
        self.split = s
        self.totalSplit = ts
    }
}
