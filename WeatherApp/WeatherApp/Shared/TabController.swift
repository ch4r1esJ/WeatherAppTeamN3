//
//  TabBar.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/1/25.
//

import UIKit

class TabController: UITabBarController {
    private var homeVC: HomeViewController!
    private var forecastVC: ForecastViewController!
    private var suggestionsVC: SuggestionViewController!
    private var citiesVC: CitiesViewController!

    let latKey = "Latitude"
    let lonKey = "Longtitude"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupTabBarAppearance()
        loadLocation()
    }
    
    private func setupTabBarAppearance() {
        tabBar.tintColor = .white
        tabBar.backgroundColor = .clear
        tabBar.isTranslucent = true
    }
    
    private func setupTabs() {
        forecastVC = ForecastViewController()
        forecastVC.tabBarItem = UITabBarItem(
            title: "Forecast",
            image: UIImage(systemName: "cloud.sun"),
            tag: 0
        )
        
        homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: 1
        )
        
        suggestionsVC = SuggestionViewController()
        suggestionsVC.tabBarItem = UITabBarItem(
            title: "Suggestions",
            image: UIImage(systemName: "append.page"),
            tag: 1
        )
        
        citiesVC = CitiesViewController()
        citiesVC.tabBarItem = UITabBarItem(
            title: "Cities",
            image: UIImage(systemName: "plus.circle"),
            tag: 1
        )
        
        citiesVC.onCitySelected = { [weak self] weatherInfo in
            self?.handleCitySelection(weatherInfo)
        }
        
        setViewControllers([homeVC, forecastVC, suggestionsVC, citiesVC], animated: true)
    }
    
    private func handleCitySelection(_ weatherInfo: WeatherFirstInfo) {
        saveLocation(lat: weatherInfo.lat, lon: weatherInfo.lon)
        homeVC.loadWeather(lat: weatherInfo.lat, lon: weatherInfo.lon)
        forecastVC.loadWeather(lat: weatherInfo.lat, lon: weatherInfo.lon)
        suggestionsVC.loadWeather(lat: weatherInfo.lat, lon: weatherInfo.lon)
        selectedIndex = 0
    }
    
    private func saveLocation(lat: Double, lon: Double) {
        UserDefaults.standard.set(lat, forKey: latKey)
        UserDefaults.standard.set(lon, forKey: lonKey)
    }
    
    private func loadLocation() {
        let savedLat = UserDefaults.standard.double(forKey: latKey)
        let savedLon = UserDefaults.standard.double(forKey: lonKey)
        
        _ = homeVC.view
        _ = forecastVC.view
        _ = suggestionsVC.view
        
        if savedLat != 0.0 && savedLon != 0.0 {
            homeVC.loadWeather(lat: savedLat, lon: savedLon)
            forecastVC.loadWeather(lat: savedLat, lon: savedLon)
            suggestionsVC.loadWeather(lat: savedLat, lon: savedLon)
        } else {
            let defaultLat = 42.3993
            let defaultLon = 42.5491
            homeVC.loadWeather(lat: defaultLat, lon: defaultLon)
            forecastVC.loadWeather(lat: defaultLat, lon: defaultLon)
            suggestionsVC.loadWeather(lat: defaultLat, lon: defaultLon)
            saveLocation(lat: defaultLat, lon: defaultLon)
        }
    }
}
