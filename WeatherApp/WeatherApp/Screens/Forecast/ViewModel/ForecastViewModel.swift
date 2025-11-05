//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Atinati on 02.11.25.
//

import Foundation

class ForecastViewModel {
    private let weatherService = WeatherService()
    private let displayService = WeatherDisplayService()
    
    private(set) var items: [ForecastItem] = [] {
        didSet { onUpdate?() }
    }
    
    private(set) var currentCityName: String = "" {
        didSet { onUpdate?() }
    }
    
    private(set) var weatherResponse: WeatherResponse?
    
    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    private let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter
    }()
    
    var weatherIconName: String {
        guard let first = items.first else { return "defaultIcon" }
        let temp = getTemp(from: first.temperatureText) ?? 20
        let display = displayService.getDisplay(iconCode: first.iconCode, temperature: temp)
        return display.iconName
    }
    
    var backgroundAssetName: String {
        guard let first = items.first else {
            return BackgroundType.sunnyDefault.assetName
        }
        let temp = getTemp(from: first.temperatureText) ?? 20
        let display = displayService.getDisplay(iconCode: first.iconCode, temperature: temp)
        return display.backgroundType.assetName
    }
    
    func loadForecast(lat: Double, lon: Double) {
        weatherService.loadForecast(lat: lat, lon: lon) { [weak self] response in
            self?.processResponse(response)
        }
    }
    
    func updateForecast(for city: String) {
        weatherService.loadWeatherForCity(city) { [weak self] response in
            guard let self = self, let response = response else {
                self?.onError?("City not found")
                return
            }
            self.processResponse(response)
        }
    }
    
    func numberOfRows() -> Int {
        items.count
    }
    
    func item(at index: Int) -> ForecastItem {
        items[index]
    }
    
    private func processResponse(_ response: WeatherResponse) {
        weatherResponse = response
        let parts = response.city.name.split(separator: ",")
        currentCityName = parts.last?.trimmingCharacters(in: .whitespacesAndNewlines) ?? response.city.name
        
        let daily = getDailyForecasts(response.list, limit: 5)
        items = daily.map { convertToForecastItem($0) }
    }
    
    private func convertToForecastItem(_ entry: WeatherItem) -> ForecastItem {
        let dayText = formatDate(entry.dtTxt)
        let temp = Int(round(entry.main.temp))
        let tempText = "\(temp)°"
        let iconCode = entry.weather.first?.icon ?? ""
        let iconURL = displayService.getIconURL(from: iconCode)
        
        return ForecastItem(
            dateText: dayText,
            imageUrl: iconURL,
            temperatureText: tempText,
            iconCode: String(iconCode.prefix(2))
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
    
    private func getTemp(from text: String) -> Double? {
        let cleaned = text.filter { "0123456789-.".contains($0) }
        return Double(cleaned)
    }
    
    private func formatDate(_ dateText: String) -> String {
        guard let date = dateFormatter.date(from: dateText) else {
            return dateText
        }
        if Calendar.current.isDateInToday(date) {
            return "Today"
        }
        return dayFormatter.string(from: date)
    }
}
