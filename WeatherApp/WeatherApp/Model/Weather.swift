//
//  Weather.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/2/25.
//

struct WeatherInfo: Codable {
    let coord: Coordinate
    let main: MainWeather
    let name: String
    
    struct Coordinate: Codable {
        let lon: Double
        let lat: Double
    }
    
    struct MainWeather: Codable {
        let temp: Double
    }
}

struct CurrentWeatherResponse: Decodable {
    let coord: Coordinates
    let name: String
}

struct Coordinates: Decodable {
    let lat: Double
    let lon: Double
}

struct WeatherResponse: Decodable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [WeatherItem]
    let city: City
}

struct WeatherItem: Decodable {
    let dt: Int
    let main: MainWeather
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let rain: Rain?
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, rain
        case dtTxt = "dt_txt"
    }
}

struct MainWeather: Decodable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

struct ForecastItem {
    let dateText: String
    let imageUrl: String
    let temperatureText: String
    let iconCode: String
}

struct WeatherDetail {
    let title: String
    let value: String
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Clouds: Decodable {
    let all: Int
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

struct Rain: Decodable {
    let threeH: Double?
    
    enum CodingKeys: String, CodingKey {
        case threeH = "3h"
    }
}

struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coordinates
    let country: String
}

struct WeatherFirstInfo: Codable {
    let name: String
    let temp: Double
    let lat: Double
    let lon: Double
}
