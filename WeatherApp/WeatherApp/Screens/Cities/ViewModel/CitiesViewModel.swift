//
//  CitiesViewModel.swift
//  WeatherApp
//
//  Created by Gegi Ghvachliani on 03.11.25.
//

import Foundation

class CitiesViewModel {
    private let citiesKey = "cities"
    private let weatherService: WeatherService
    private let displayService = WeatherDisplayService()
    
    private(set) var cities: [WeatherFirstInfo] = [] {
        didSet {
            onCitiesUpdated?()
            saveCities()
        }
    }
    
    var onCitiesUpdated: (() -> Void)?
    
    var citiesCount: Int {
        cities.count
    }
    
    init(weatherService: WeatherService = WeatherService()) {
        self.weatherService = weatherService
        loadCities()
    }
    
    func backgroundAssetName(for city: WeatherFirstInfo) -> String {
        let display = displayService.getDisplay(iconCode: "01d", temperature: city.temp)
        return display.backgroundType.assetName
    }
    
    func addCity(_ name: String, completion: @escaping (Bool) -> Void) {
        let exists = cities.contains { $0.name.lowercased() == name.lowercased() }
        if exists {
            completion(false)
            return
        }
        
        weatherService.getFirstInfo(for: name) { [weak self] result in
            switch result {
            case .success(let info):
                self?.cities.append(info)
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    func getCity(at index: Int) -> WeatherFirstInfo? {
        guard index < cities.count else { return nil }
        return cities[index]
    }
    
    func removeCity(at index: Int) {
        guard index < cities.count else { return }
        cities.remove(at: index)
    }
    
    private func saveCities() {
        guard let data = try? JSONEncoder().encode(cities) else { return }
        UserDefaults.standard.set(data, forKey: citiesKey)
    }
    
    private func loadCities() {
        guard let data = UserDefaults.standard.data(forKey: citiesKey),
              let decoded = try? JSONDecoder().decode([WeatherFirstInfo].self, from: data) else {
            return
        }
        cities = decoded
    }
}
