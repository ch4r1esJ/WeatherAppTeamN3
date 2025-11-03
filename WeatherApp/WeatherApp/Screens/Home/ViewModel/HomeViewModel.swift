//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/3/25.
//

import Foundation
import UIKit

class HomeViewModel {
    private let weatherService: WeatherService
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
    
    func getIconURL(from iconCode: String) -> String {
        return "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
    }
    
    func getCurrentWeatherIcon() -> String? {
        return weatherResponse?.list.first?.weather.first?.icon
    }
    
    var temperature: String {
        guard let temp = weatherResponse?.list.first?.main.temp else { return "--" }
        return "\(Int(temp))"
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
        let today = dateFormatter.string(from: Date())
        
        return Array(list.prefix(8))
    }

    func numberOfForecastItems() -> Int {
        return todaysForecast.count
    }

    func forecastItem(at index: Int) -> (temperature: String, icon: UIImage?, time: String) {
        guard index < todaysForecast.count else {
            return ("--", nil, "--")
        }
        
        let item = todaysForecast[index]
        
        let temp = "\(Int(item.main.temp))°C"
        let iconCode = item.weather.first?.icon ?? "01d"
        let icon = UIImage(named: getIconName(from: iconCode))
        let time = formatTime(from: item.dtTxt)
        
        return (temp, icon, time)
    }

    private func formatTime(from dateString: String) -> String {
        let components = dateString.split(separator: " ")
        guard components.count > 1 else { return "" }
        let time = String(components[1])
        return String(time.prefix(5))
    }

    private func getIconName(from iconCode: String) -> String {
        switch iconCode {
        case "01d", "01n": return "sunIcon"
        case "02d", "02n": return "cloudIcon"
        case "03d", "03n", "04d", "04n": return "cloudIcon"
        case "09d", "09n", "10d", "10n": return "rainIcon"
        case "11d", "11n": return "thunderstormIcon"
        case "13d", "13n": return "snowIcon"
        default: return "cloudIcon"
        }
    }
}
