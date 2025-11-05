//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/2/25.
//

import Foundation

class WeatherService {
    private let networkManager: NetworkManager
    private(set) var weatherResponse: WeatherResponse?
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getFirstInfo(for city: String, completion: @escaping (Result<WeatherFirstInfo, Error>) -> Void) {
        let url = "\(Config.baseURL)/weather?q=\(city)&appid=\(Config.weatherAPIKey)&units=metric"
        
        networkManager.getData(url: url) { (result: Result<WeatherInfo, Error>) in
            switch result {
            case .success(let weather):
                let info = WeatherFirstInfo(
                    name: weather.name,
                    temp: weather.main.temp,
                    lat: weather.coord.lat,
                    lon: weather.coord.lon
                )
                completion(.success(info))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCoordinates(for city: String, completion: @escaping (Double, Double) -> Void) {
        let url = "\(Config.baseURL)/weather?q=\(city)&appid=\(Config.weatherAPIKey)&units=metric"
        
        networkManager.getData(url: url) { (result: Result<CurrentWeatherResponse, Error>) in
            if case .success(let weather) = result {
                completion(weather.coord.lat, weather.coord.lon)
            }
        }
    }
    
    func loadForecast(lat: Double, lon: Double, completion: @escaping (WeatherResponse) -> Void) {
        let url = "\(Config.baseURL)/forecast?lat=\(lat)&lon=\(lon)&appid=\(Config.forecastAPIKey)&units=metric"
        
        networkManager.getData(url: url) { (result: Result<WeatherResponse, Error>) in
            if case .success(let response) = result {
                self.weatherResponse = response
                completion(response)
            }
        }
    }
    
    func loadWeatherForCity(_ city: String, completion: @escaping (WeatherResponse?) -> Void) {
        getCoordinates(for: city) { [weak self] lat, lon in
            self?.loadForecast(lat: lat, lon: lon) { response in
                completion(response)
            }
        }
    }
}
