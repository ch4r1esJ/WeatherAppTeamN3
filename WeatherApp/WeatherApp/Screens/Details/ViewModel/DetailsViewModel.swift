//
//  DetailsViewModel.swift
//  WeatherApp
//
//  Created by Luka Ushikishvili on 11/4/25.
//

import Foundation
import UIKit

class DetailsViewModel {
    
    var cityName: String = "Tsqaltubo"
    var iconName: String = "heavyrainIcon"
    var details: [WeatherDetail] = []
    var weatherService = WeatherService()
    var currentTemp: Double = 0.0
    
    func loadWeatherDetails(lat: Double, lon: Double, completion: @escaping () -> Void) {
        weatherService.loadWeatherForcast(lat: lat, lon: lon) { [weak self] response in
            guard let self = self else { return }
            
            let first = response.list.first
            self.cityName = response.city.name
            self.currentTemp = first?.main.temp ?? 0.0
            
            // dinamiurad irchevs icons
            let prefix = String(first?.weather.first?.icon.prefix(2) ?? "01")
            let isCold = self.currentTemp <= 10
            self.iconName = WeatherIconManager.iconName(for: prefix, isCold: isCold)
            
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
    
    func backgroundImage(for temp: Double) -> UIImage? {
        if temp <= 10 {
            return UIImage(named: BackgroundType.coldWeather.assetName)
        } else {
            return UIImage(named: BackgroundType.sunnyDefault.assetName)
        }
    }
}
