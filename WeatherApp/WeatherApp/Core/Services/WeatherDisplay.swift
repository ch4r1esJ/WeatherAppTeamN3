//
//  WeatherDisplayService.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/2/25.
//

import Foundation

struct WeatherDisplay {
    let iconName: String
    let backgroundType: BackgroundType
}

class WeatherDisplayService {
    func getDisplay(iconCode: String, temperature: Double) -> WeatherDisplay {
        let isCold = temperature <= Config.coldTempThreshold
        let iconName = WeatherIconManager.iconName(for: String(iconCode.prefix(2)), isCold: isCold)
        let backgroundType: BackgroundType = isCold ? .coldWeather : .sunnyDefault
        
        return WeatherDisplay(iconName: iconName, backgroundType: backgroundType)
    }
    
    func getIconURL(from code: String) -> String {
        return "\(Config.iconBaseURL)/\(code)@2x.png"
    }
}
