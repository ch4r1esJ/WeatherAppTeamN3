//
//  Config.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/2/25.
//

import Foundation

enum Config {
    static let weatherAPIKey = "390b1c9d792d64568df3ea91ce636c59"
    static let forecastAPIKey = "eda9b39a8f8b30c8f5eddbf6f47013f0"
    
    static let baseURL = "https://api.openweathermap.org/data/2.5"
    static let iconBaseURL = "https://openweathermap.org/img/wn"
    
    static let coldTempThreshold: Double = 10.0
    static let defaultLocation = (lat: 42.3993, lon: 42.5491)
}
