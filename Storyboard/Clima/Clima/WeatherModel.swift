//
//  WeatherModel.swift
//  Clima
//
//  Created by Andrey Ramirez on 6/28/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    //  these 3 are stored properties
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    // computed property
    // computed based off of temperature
    // should always be var since this is based off of a computation
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    // computed property
    // computed based off of conditionId
    // should always be var since this is based off of a computation
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
