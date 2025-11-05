//
//  LocationService.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/2/25.
//

import Foundation

class LocationService {
    private let latKey = "Latitude"
    private let lonKey = "Longitude"
    
    func save(lat: Double, lon: Double) {
        UserDefaults.standard.set(lat, forKey: latKey)
        UserDefaults.standard.set(lon, forKey: lonKey)
    }
    
    func load() -> (lat: Double, lon: Double) {
        let lat = UserDefaults.standard.double(forKey: latKey)
        let lon = UserDefaults.standard.double(forKey: lonKey)
        
        if lat != 0.0 && lon != 0.0 {
            return (lat, lon)
        }
        return Config.defaultLocation
    }
}
