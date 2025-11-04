//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Atinati on 02.11.25.
//
import Foundation
import UIKit
 
@MainActor
class ForecastViewModel {
    
    private(set) var items: [ForecastItem] = [] {
        didSet { onUpdate?() }
    }
    
    private(set) var currentCityName: String = "" {
        didSet { onUpdate?() }
    }
    var cityName: String {
        let raw = weatherResponse?.city.name ?? "Unknown"
        return raw.components(separatedBy: ",").last?.trimmingCharacters(in: .whitespacesAndNewlines) ?? raw
    }
    
    private(set) var weatherResponse: WeatherResponse?
    
    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    
    // MARK: Dependencies
    
    private let service = WeatherService()
    private let inputFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }()
    
    private let outputFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter
    }()
    
    // MARK: Public API
    
    func loadForecast(
        lat: Double = 42.3993,
        lon: Double = 42.5491
    ) {
        service.loadWeatherForcast(lat: lat, lon: lon) { [weak self] weatherResponse in
            guard let self else { return }
            self.processResponse(weatherResponse)
        }
    }
    
    func updateForecast(for cityName: String) {
        service.loadWeatherForCity(cityName) { [weak self] response in
            guard let self = self, let response = response else {
                self?.onError?("City not found")
                return
            }
            self.processResponse(response)
        }
    }
 
    func backgroundImage() -> UIImage? {
        let defaultImage = UIImage(named: BackgroundType.sunnyDefault.assetName)
        
        guard let firstEntry = items.first,
              let currentTemp = getTemperatureValue(from: firstEntry.temperatureText) else {
            return defaultImage
        }
        if currentTemp <= 10.0 {
            return UIImage(named: BackgroundType.coldWeather.assetName)
        } else {
            return defaultImage
        }
    }
    
    func weatherIconImage() -> UIImage? {
        guard let firstEntry = items.first else { return UIImage(named: "defaultIcon") }
        let currentTemp = getTemperatureValue(from: firstEntry.temperatureText) ?? 20
        let isCold = currentTemp <= 10.0
        let iconName = WeatherIconManager.iconName(for: firstEntry.iconCode, isCold: isCold)
        
        print("WEATHER ICON: code=\(firstEntry.iconCode), temp=\(currentTemp)°C, isCold=\(isCold) → \(iconName)")
        
        return UIImage(named: iconName)
    }
    
    // MARK: Transform
    
    private func convertToForecastItem(_ entry: WeatherItem) -> ForecastItem {
        let dayText = formatDate(entry.dtTxt)
        
        let tempRounded = Int(round(entry.main.temp))
        let tempText = "\(tempRounded)°"
        
        let iconCode = entry.weather.first?.icon ?? ""
        let iconURL = "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
        
        return ForecastItem(
            dateText: dayText,
            imageUrl: iconURL,
            temperatureText: tempText,
            iconCode: String(iconCode.prefix(2))
        )
    }
    
    private func processResponse(_ response: WeatherResponse) {
        self.weatherResponse = response
 
        let rawName = response.city.name
        let parts = rawName.split(separator: ",")
        let cleaned = parts.last?.trimmingCharacters(in: .whitespacesAndNewlines) ?? rawName
        self.currentCityName = cleaned
        let daily = getDailyForecasts(response.list, limit: 5)
        let mapped = daily.map { convertToForecastItem($0) }
        self.items = mapped
    }
    
    private func getDailyForecasts(_ entries: [WeatherItem], limit: Int) -> [WeatherItem] {
        var result: [WeatherItem] = []
        var seenDays = Set<String>()
        
        for entry in entries {
            let dayKey = String(entry.dtTxt.prefix(10))
            
            if !seenDays.contains(dayKey) {
                seenDays.insert(dayKey)
                result.append(entry)
            }
            
            if result.count == limit { break }
        }
        
        return result
    }
    
    private func getTemperatureValue(from text: String) -> Double? {
        let cleanedString = text.filter { "0123456789-.".contains($0) }
        return Double(cleanedString)
    }
    
    private func formatDate(_ dateText: String) -> String {
        guard let date = inputFormatter.date(from: dateText) else {
            return dateText
        }
        
        if Calendar.current.isDateInToday(date) {
            return "Today"
        }
        
        return outputFormatter.string(from: date)
    }
    
    func numberOfRows() -> Int {
        return items.count
    }
    
    func item(at index: Int) -> ForecastItem {
        return items[index]
    }
}
 
 
