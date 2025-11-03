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
    
    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    
    // MARK: Dependencies
    
    private let service = WeatherService()
    
    // MARK: Public API
    
     func loadForecast(
         lat: Double = 43.7151,
         lon: Double = 42.8271
     ) {
         service.loadWeatherForcast(lat: lat, lon: lon) { [weak self] weatherResponse in
             guard let self else { return }
             let rawEntries = weatherResponse.list
             let daily = self.getDailyForecasts(rawEntries, limit: 15)
             let mapped = daily.map { self.convertToForecastItem($0) }
             self.items = mapped
         }
     }
     
    func numberOfRows() -> Int {
        return items.count
    }
        
    func item(at index: Int) -> ForecastItem {
        return items[index]
    }
        
        // MARK: UI Convenience (for ViewController)
        
    func backgroundImage() -> UIImage? {
        guard let firstEntry = items.first else {
            return UIImage(named: BackgroundType.sunnyDefault.assetName)
        }
        
        let tempText = firstEntry.temperatureText
        guard let currentTemp = getTemperatureValue(from: tempText) else {
            return UIImage(named: BackgroundType.sunnyDefault.assetName)
        }
        
        let isTooCold = currentTemp <= 10.0
        
        if isTooCold {
            return UIImage(named: BackgroundType.coldWeather.assetName)
        } else {
            return UIImage(named: BackgroundType.sunnyDefault.assetName)
        }
    }
        
    func weatherIconImage() -> UIImage? {
        guard let firstEntry = items.first else {
            return UIImage(named: "defaultIcon")
        }
        
        let urlString = firstEntry.imageUrl
        let iconPrefix = urlString
            .split(separator: "/")
            .last?
            .prefix(2)
            .description ?? ""
        let iconName = WeatherIconManager.iconName(for: iconPrefix)
        return UIImage(named: iconName)
    }
        
        // MARK: Mapping / Transform
        
    private func convertToForecastItem(_ entry: WeatherItem) -> ForecastItem {
        let dayText = formatDate(entry.dtTxt)
        
        let tempRounded = Int(round(entry.main.temp))
        let tempText = "\(tempRounded)°"
        
        let iconCode = entry.weather.first?.icon ?? ""
        let iconURL = "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
        
        return ForecastItem(
            dateText: dayText,
            imageUrl: iconURL,
            temperatureText: tempText
        )
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
        
        // MARK: Date formatting
        
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
        
    private func formatDate(_ dateText: String) -> String {
        guard let date = inputFormatter.date(from: dateText) else {
            return dateText
        }
        
        if Calendar.current.isDateInToday(date) {
            return "Today"
        }
        
        return outputFormatter.string(from: date)
    }
}


