//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/3/25.
//

import Foundation
import UIKit

class HomeViewModel {
    // MARK: Properties
    
    private let weatherService: WeatherService
    private(set) var weatherResponse: WeatherResponse?
    
    var onWeatherLoaded: ((WeatherResponse) -> Void)?
    
    // MARK: Init
    
    init(weatherService: WeatherService = WeatherService()) {
        self.weatherService = weatherService
    }
    
    var temperature: String {
        guard let temp = weatherResponse?.list.first?.main.temp else { return "--" }
        return "\(Int(temp))°"
    }
    
    var max: String {
        guard let maxTemp = weatherResponse?.list.first?.main.tempMax else { return "--" }
        return "\(Int(maxTemp))"
    }
    
    var min: String {
        guard let minTemp = weatherResponse?.list.first?.main.tempMin else { return "--" }
        return "\(Int(minTemp))"
    }
    
    var cityName: String {
        weatherResponse?.city.name ?? "Unknown"
    }
    
    private var todaysForecast: [WeatherItem] {
        guard let list = weatherResponse?.list else { return [] }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        _ = dateFormatter.string(from: Date())
        return Array(list.prefix(8))
    }
    
    func numberOfForecastItems() -> Int {
        return todaysForecast.count
    }
    
    func loadWeather(lat: Double, lon: Double) {
        weatherService.loadWeatherForcast(lat: lat, lon: lon) { [weak self] response in
            self?.weatherResponse = response
            self?.onWeatherLoaded?(response)
        }
    }
    
    func getIconURL(from iconCode: String) -> String {
        return "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
    }
    
    func getCurrentWeatherIcon() -> String? {
        return weatherResponse?.list.first?.weather.first?.icon
    }
    
    private func formatTime(from dateString: String) -> String {
        let components = dateString.split(separator: " ")
        guard components.count > 1 else { return "" }
        let time = String(components[1])
        return String(time.prefix(5))
    }
    
    private func getTemperatureValue(from text: String) -> Double? {
        let cleanedString = text.filter { "0123456789-.".contains($0) }
        return Double(cleanedString)
    }
    
    func forecastIcon(at index: Int) -> (temperature: String, iconURL: String, time: String) {
        guard index < todaysForecast.count else {
            return ("--", "", "--")
        }
        let item = todaysForecast[index]
        let temp = "\(Int(item.main.temp))°C"
        let iconCode = item.weather.first?.icon ?? "01d"
        let iconURL = getIconURL(from: iconCode)
        let time = formatTime(from: item.dtTxt)
        return (temp, iconURL, time)
    }
    
    func backgroundImage() -> UIImage? {
        let defaultImage = UIImage(named: BackgroundType.sunnyDefault.assetName)
        guard let firstEntry = weatherResponse?.list.first else {
            return defaultImage
        }
        let currentTemp = firstEntry.main.temp
        if currentTemp <= 10 {
            return UIImage(named: BackgroundType.coldWeather.assetName)
        } else {
            return defaultImage
        }
    }
    
    func weatherIconImage() -> UIImage? {
        guard let firstEntry = weatherResponse?.list.first else {
            return UIImage(named: "defaultIcon")
        }
        let fullCode = firstEntry.weather.first?.icon ?? "01d"
        let prefix = String(fullCode.prefix(2))
        let temp = firstEntry.main.temp
        let isCold = temp <= 10
        let iconName = WeatherIconManager.iconName(for: prefix, isCold: isCold)
        return UIImage(named: iconName) ?? UIImage(named: "defaultIcon")
    }
}
