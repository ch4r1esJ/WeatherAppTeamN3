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
    
    func getCoordinates(for cityName: String, completion: @escaping (Double, Double) -> ()) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=390b1c9d792d64568df3ea91ce636c59"
        
        networkManager.getData(url: url) { (result: Result<CurrentWeatherResponse, Error>) in
            
            switch result {
            case .success(let weather):
                let lat = weather.coord.lat
                let lon = weather.coord.lon
                completion(lat,lon)
                
            case .failure(let error):
                print("Failed to get coordinates: \(error.localizedDescription)")
            }
        }
    }
    
    func loadWeatherForcast(lat: Double, lon: Double, completion: @escaping (WeatherResponse) -> ()) {
            let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=eda9b39a8f8b30c8f5eddbf6f47013f0&units=metric"
            
            networkManager.getData(url: url) { (result: Result<WeatherResponse, Error>) in
                switch result {
                case .success(let weatherResponse):
                    print("City: \(weatherResponse.city.name)")
                    self.weatherResponse = weatherResponse
                    completion(weatherResponse)
    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    
    func loadWeatherForCity(_ cityName: String, completion: @escaping (WeatherResponse?) -> Void) {
           getCoordinates(for: cityName) { [weak self] lat, lon in
               self?.loadWeatherForcast(lat: lat, lon: lon, completion: completion)
           }
       }
}
