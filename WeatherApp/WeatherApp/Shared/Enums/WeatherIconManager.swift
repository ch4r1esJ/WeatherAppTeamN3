//
//  WeatherIconManager.swift
//  WeatherApp
//
//  Created by Atinati on 02.11.25.
//

import Foundation

enum WeatherIconManager {
    
    private static let thunderCodes: Set<String> = ["11"]
    private static let snowCodes: Set<String> = ["13"]
    private static let rainCodes: Set<String> = ["09", "10"]
    private static let cloudyCodes: Set<String> = ["03", "04", "50"]
    private static let sunCodes: Set<String> = ["01", "02"]
    
    static func iconName(for codePrefix: String, isCold: Bool = false) -> String {
        let prefix = codePrefix.trimmingCharacters(in: .whitespaces)
        if !isCold && (prefix == "03" || prefix == "04") {
            return "cloudySunIcon"
        }
        if isCold {
            if thunderCodes.contains(prefix) { return "thunderIcon" }
            if snowCodes.contains(prefix) { return "snowIcon" }
            if rainCodes.contains(prefix) { return "rainIcon" }
            if cloudyCodes.contains(prefix) { return "cloudyIcon" }
            return "cloudyIcon"
        }
        
        if thunderCodes.contains(prefix) { return "thunderIcon" }
        if snowCodes.contains(prefix) { return "snowIcon" }
        if rainCodes.contains(prefix) { return "rainIcon" }
        if cloudyCodes.contains(prefix) { return "cloudyIcon" }
        if sunCodes.contains(prefix) { return "sunIcon" }
        
        return "defaultIcon"
    }
}

enum BackgroundType: String {
    case coldWeather = "badweatherBackground"
    case sunnyDefault = "defaultBackground"
    
    var assetName: String {
        return self.rawValue
    }
}
