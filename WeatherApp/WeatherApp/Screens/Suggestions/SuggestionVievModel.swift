//
//  SuggestionViewModel.swift
//  WeatherApp
//
//  Created by Gegi Ghvachliani on 04.11.25.
//

import Foundation

class SuggestionViewModel {
    private let weatherService: WeatherService
    private let suggestionManager = SuggestionManager()
    private let displayService = WeatherDisplayService()
    
    private(set) var weatherResponse: WeatherResponse? {
        didSet { onWeatherLoaded?(weatherResponse) }
    }
    
    var onWeatherLoaded: ((WeatherResponse?) -> Void)?
    
    var cityName: String {
        weatherResponse?.city.name ?? "Unknown"
    }
    
    var temperature: String {
        guard let temp = weatherResponse?.list.first?.main.temp else { return "--" }
        return "\(Int(temp))°C"
    }
    
    var weatherIconName: String {
        guard let first = weatherResponse?.list.first else { return "sunIcon" }
        let iconCode = first.weather.first?.icon ?? "01d"
        return getBasicIconName(from: iconCode)
    }
    
    var backgroundAssetName: String {
        guard let first = weatherResponse?.list.first else {
            return BackgroundType.sunnyDefault.assetName
        }
        let iconCode = first.weather.first?.icon ?? "01d"
        let display = displayService.getDisplay(iconCode: iconCode, temperature: first.main.temp)
        return display.backgroundType.assetName
    }
    
    init(weatherService: WeatherService = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func loadWeather(lat: Double, lon: Double) {
        weatherService.loadForecast(lat: lat, lon: lon) { [weak self] response in
            self?.weatherResponse = response
        }
    }
    
    func getSuggestions() -> [String] {
        suggestionManager.getSuggestions(for: weatherIconName)
    }
    
    private func getBasicIconName(from code: String) -> String {
        switch code {
        case "01d", "01n": return "sunIcon"
        case "02d", "02n": return "cloudyIcon"
        case "03d", "03n", "04d", "04n": return "cloudyIcon"
        case "09d", "09n", "10d", "10n": return "rainIcon"
        case "11d", "11n": return "thunderIcon"
        case "13d", "13n": return "snowIcon"
        case "50d", "50n": return "foggyIcon"
        default: return "sunIcon"
        }
    }
}
