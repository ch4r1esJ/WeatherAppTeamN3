//
//  WeatherIconMapper.swift
//  WeatherApp
//
//  Created by Atinati on 02.11.25.
//
enum WeatherIconManager {
    
    private static let thunderCodes: Set<String> = ["11"]
    private static let snowCodes: Set<String> = ["13"]
    private static let rainCodes: Set<String> = ["09", "10"] 
    private static let cloudyCodes: Set<String> = ["03", "04", "50"]
    private static let sunCodes: Set<String> = ["01", "02"]

    static func iconName(for codePrefix: String) -> String {
        if thunderCodes.contains(codePrefix) {
            return "thunderIcon"
        }
        
        if snowCodes.contains(codePrefix) {
            return "snowIcon"
        }
        
        if rainCodes.contains(codePrefix) {
            return "rainIcon"
        }
        
        if cloudyCodes.contains(codePrefix) {
            return "cloudyIcon"
        }
        
        if sunCodes.contains(codePrefix) {
            return "sunIcon"
        }
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
