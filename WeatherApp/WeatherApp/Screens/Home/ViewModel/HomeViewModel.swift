//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/3/25.
//

import Foundation

class HomeViewModel {
    private let weatherService: WeatherService
    private let displayService = WeatherDisplayService()
    
    private(set) var weatherResponse: WeatherResponse? {
        didSet { onWeatherLoaded?(weatherResponse) }
    }
    
    var onWeatherLoaded: ((WeatherResponse?) -> Void)?
    
    init(weatherService: WeatherService = WeatherService()) {
        self.weatherService = weatherService
    }
    
    var temperature: String {
        guard let temp = weatherResponse?.list.first?.main.temp else { return "--" }
        return "\(Int(temp))°"
    }
    
    var maxTemp: String {
        guard let max = weatherResponse?.list.first?.main.tempMax else { return "--" }
        return "\(Int(max))"
    }
    
    var minTemp: String {
        guard let min = weatherResponse?.list.first?.main.tempMin else { return "--" }
        return "\(Int(min))"
    }
    
    var cityName: String {
        weatherResponse?.city.name ?? "Unknown"
    }
    
    var weatherIconName: String {
        guard let first = weatherResponse?.list.first else { return "defaultIcon" }
        let iconCode = first.weather.first?.icon ?? "01d"
        let display = displayService.getDisplay(iconCode: iconCode, temperature: first.main.temp)
        return display.iconName
    }
    
    var backgroundAssetName: String {
        guard let first = weatherResponse?.list.first else {
            return BackgroundType.sunnyDefault.assetName
        }
        let iconCode = first.weather.first?.icon ?? "01d"
        let display = displayService.getDisplay(iconCode: iconCode, temperature: first.main.temp)
        return display.backgroundType.assetName
    }
    
    func loadWeather(lat: Double, lon: Double) {
        weatherService.loadForecast(lat: lat, lon: lon) { [weak self] response in
            self?.weatherResponse = response
        }
    }
    
    func numberOfForecastItems() -> Int {
        return Array((weatherResponse?.list ?? []).prefix(8)).count
    }
    
    func forecastItem(at index: Int) -> (temp: String, iconURL: String, time: String) {
        guard let list = weatherResponse?.list, index < min(list.count, 8) else {
            return ("--", "", "--")
        }
        
        let item = list[index]
        let temp = "\(Int(item.main.temp))°C"
        let iconCode = item.weather.first?.icon ?? "01d"
        let iconURL = displayService.getIconURL(from: iconCode)
        let time = formatTime(from: item.dtTxt)
        
        return (temp, iconURL, time)
    }
    
    private func formatTime(from dateString: String) -> String {
        let parts = dateString.split(separator: " ")
        guard parts.count > 1 else { return "" }
        let time = String(parts[1])
        return String(time.prefix(5))
    }
}
