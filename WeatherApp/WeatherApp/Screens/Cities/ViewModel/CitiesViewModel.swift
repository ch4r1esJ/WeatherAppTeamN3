//
//  Untitled.swift
//  WeatherApp
//
//  Created by Gegi Ghvachliani on 03.11.25.
//
//

import UIKit

class CitiesViewModel {
    // MARK: Properties
    private let citiesKey = "cities"
    
    private(set) var cities: [WeatherFirstInfo] = [] {
        didSet {
            onCitiesUpdated?()
            saveCities()
        }
    }
    
    private let weatherService: WeatherService
    var onCitiesUpdated: (() -> Void)?
    var citiesCount: Int {
        cities.count
    }
    
    // MARK: Initialization
    
    init(weatherService: WeatherService = WeatherService()) {
        self.weatherService = weatherService
        loadCities()
    }
    
    // MARK: Methods
    
    private func saveCities() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(cities)
            UserDefaults.standard.set(data, forKey: citiesKey)
        } catch {
            print(error)
        }
    }
    
    private func loadCities() {
        guard let data = UserDefaults.standard.data(forKey: citiesKey) else {
            return
        }
        do {
            let decoder = JSONDecoder()
            cities = try decoder.decode([WeatherFirstInfo].self, from: data)
        } catch {
            print(error)
        }
    }
    
    func backgroundImage(for city: WeatherFirstInfo) -> UIImage? {
        let isCold = city.temp <= 10
        return UIImage(
            named: isCold ? BackgroundType.coldWeather.assetName
            : BackgroundType.sunnyDefault.assetName
        )
    }
    
    func addCity(_ cityName: String, completion: @escaping (Bool) -> Void) {
        let cityExists = cities.contains { city in
                city.name.lowercased() == cityName.lowercased()
            }

            if cityExists {
                completion(false)
                return
            }
        
        weatherService.getFirstInfo(for: cityName) { [weak self] result in
            switch result {
            case .success(let weatherInfo):
                self?.cities.append(weatherInfo)
                self?.onCitiesUpdated?()
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
        onCitiesUpdated?()
    }
}
