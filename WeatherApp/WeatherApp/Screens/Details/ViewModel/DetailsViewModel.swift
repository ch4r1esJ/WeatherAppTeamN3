//
//  DetailsViewModel.swift
//  WeatherApp
//
//  Created by Luka Ushikishvili on 11/4/25.
//

import Foundation
import UIKit
// sheicvleba aqauroba. ui-s chvenebisas ro empty ariyos magitoa hardcoded :D
class DetailsViewModel {
    
    var cityName: String = "Tsqaltubo"
    var iconName: String = "heavyrainIcon"
    var details: [WeatherDetail] = []

    func loadMockData() {
        details = [
            WeatherDetail(title: "Feels Like", value: "7.4 °C"),
            WeatherDetail(title: "Humidity", value: "78%"),
            WeatherDetail(title: "Pressure", value: "1029 hPa"),
            WeatherDetail(title: "Wind Speed", value: "2.4 km/h"),
            WeatherDetail(title: "Cloudiness", value: "15%"),
            WeatherDetail(title: "Visibility", value: "10,000 m"),
            WeatherDetail(title: "Condition", value: "Few Clouds")
        ]
    }
}
