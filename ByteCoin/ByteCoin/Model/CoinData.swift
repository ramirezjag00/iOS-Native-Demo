//
//  CoinData.swift
//  ByteCoin
//
//  Created by Andrey Ramirez on 7/1/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    // exact key/properties in the response data we need

    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
