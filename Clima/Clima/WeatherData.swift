//
//  WeatherData.swift
//  Clima
//
//  Created by Andrey Ramirez on 6/28/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

// protocol Decodable
// protocol Encodable
// Codable is a typealias or basically typescript union
// typealias Codable = Decodable & Encodable
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
}
