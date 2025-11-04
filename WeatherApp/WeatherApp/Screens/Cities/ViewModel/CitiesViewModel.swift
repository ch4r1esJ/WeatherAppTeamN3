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
    private(set) var cities: [WeatherFirstInfo] = []
    
    private let weatherService: WeatherService
    
    var onCitiesUpdated: (() -> Void)?
    
    var citiesCount: Int {
        cities.count
    }
    
    // MARK: Initialization
    init(weatherService: WeatherService = WeatherService()) {
        self.weatherService = weatherService
    }
    
    // MARK: Methods
    func backgroundImage(for city: WeatherFirstInfo) -> UIImage? {
        let isCold = city.temp <= 10
        return UIImage(
            named: isCold ? BackgroundType.coldWeather.assetName
            : BackgroundType.sunnyDefault.assetName
        )
    }
    
    func addCity(_ cityName: String, completion: @escaping (Bool) -> Void) {
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
