//
//  SuggestionVievModel.swift
//  WeatherApp
//
//  Created by Gegi Ghvachliani on 04.11.25.
//
import Foundation
import UIKit

class SuggestionViewModel {
    var onUpdate: (() -> Void)?
    private(set) var items: [ForecastItem] = [] {
        didSet { onUpdate?() }
    }
    
    private let weatherService: WeatherService
    private let suggestionManager = SuggestionManager()
    private(set) var weatherResponse: WeatherResponse?
    
    var onWeatherLoaded: ((WeatherResponse) -> Void)?
    
    init(weatherService: WeatherService = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func loadWeather(for cityName: String) {
        weatherService.loadWeatherForCity(cityName) { [weak self] response in
            guard let response = response else { return }
            self?.weatherResponse = response
            self?.onWeatherLoaded?(response)
        }
    }
    
    func loadWeather(lat: Double, lon: Double) {
        weatherService.loadWeatherForcast(lat: lat, lon: lon) { [weak self] response in
            self?.weatherResponse = response
            self?.onWeatherLoaded?(response)
        }
    }
    
    var cityName: String {
        weatherResponse?.city.name ?? "Unknown"
    }
    
    var temperature: String {
        guard let temp = weatherResponse?.list.first?.main.temp else { return "--" }
        return "\(Int(temp))°C"
    }
    
    var weatherIconName: String {
        guard let iconCode = weatherResponse?.list.first?.weather.first?.icon else {
            return "sunIcon"
        }
        return getIconName(from: iconCode)
    }
    
    func getSuggestions() -> [String] {
        return suggestionManager.getSuggestions(for: weatherIconName)
    }
    
    func backgroundImage() -> UIImage? {
        guard let temp = weatherResponse?.list.first?.main.temp else {
            return UIImage(named: BackgroundType.sunnyDefault.assetName)
        }
        
        if temp <= 10.0 {
            return UIImage(named: BackgroundType.coldWeather.assetName)
        } else {
            return UIImage(named: BackgroundType.sunnyDefault.assetName)
        }
    }
    
    private func getTemperatureValue(from text: String) -> Double? {
            let cleanedString = text.filter { "0123456789-.".contains($0) }
            return Double(cleanedString)
        }
    
    private func getIconName(from iconCode: String) -> String {
        switch iconCode {
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
