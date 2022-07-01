//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Andrey Ramirez on 7/1/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let time: String
    let coinSymbol: String
    let currencyPairSymbol: String
    let rate: Double
    
    var rateString: String {
        return String(format: "%.2f", rate)
    }
}
