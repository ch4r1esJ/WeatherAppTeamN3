//
//  DetailsViewModel.swift
//  WeatherApp
//
//  Created by Luka Ushikishvili on 11/4/25.
//

import Foundation

class DetailsViewModel {
    private let weatherService = WeatherService()
    private let displayService = WeatherDisplayService()
    
    var cityName: String = ""
    var details: [WeatherDetail] = []
    
    private var currentTemp: Double = 0.0
    
    var weatherIconName: String {
        guard let first = weatherService.weatherResponse?.list.first else {
            return "defaultIcon"
        }
        let iconCode = first.weather.first?.icon ?? "01d"
        let display = displayService.getDisplay(iconCode: iconCode, temperature: first.main.temp)
        return display.iconName
    }
    
    var backgroundAssetName: String {
        let display = displayService.getDisplay(iconCode: "01d", temperature: currentTemp)
        return display.backgroundType.assetName
    }
    
    func loadWeatherDetails(lat: Double, lon: Double, completion: @escaping () -> Void) {
        weatherService.loadForecast(lat: lat, lon: lon) { [weak self] response in
            guard let self = self else { return }
            
            let first = response.list.first
            self.cityName = response.city.name
            self.currentTemp = first?.main.temp ?? 0.0
            
            self.details = [
                WeatherDetail(title: "Feels Like", value: "\(first?.main.feelsLike ?? 0) °C"),
                WeatherDetail(title: "Humidity", value: "\(first?.main.humidity ?? 0)%"),
                WeatherDetail(title: "Pressure", value: "\(first?.main.pressure ?? 0) hPa"),
                WeatherDetail(title: "Wind Speed", value: "\(first?.wind.speed ?? 0) km/h"),
                WeatherDetail(title: "Cloudiness", value: "\(first?.clouds.all ?? 0)%"),
                WeatherDetail(title: "Visibility", value: "\(first?.visibility ?? 0) m"),
                WeatherDetail(title: "Condition", value: first?.weather.first?.description.capitalized ?? "")
            ]
            
            completion()
        }
    }
}
