//
//  TabController.swift
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
    
    private let locationService = LocationService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupTabBarAppearance()
        loadInitialLocation()
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
            tag: 2
        )
        
        citiesVC = CitiesViewController()
        citiesVC.tabBarItem = UITabBarItem(
            title: "Cities",
            image: UIImage(systemName: "plus.circle"),
            tag: 3
        )
        
        citiesVC.onCitySelected = { [weak self] weatherInfo in
            self?.handleCitySelection(weatherInfo)
        }
        
        setViewControllers([homeVC, forecastVC, suggestionsVC, citiesVC], animated: true)
    }
    
    private func handleCitySelection(_ weatherInfo: WeatherFirstInfo) {
        locationService.save(lat: weatherInfo.lat, lon: weatherInfo.lon)
        loadWeather(lat: weatherInfo.lat, lon: weatherInfo.lon)
        selectedIndex = 0
    }
    
    private func loadInitialLocation() {
        _ = homeVC.view
        _ = forecastVC.view
        _ = suggestionsVC.view
        
        let location = locationService.load()
        loadWeather(lat: location.lat, lon: location.lon)
        locationService.save(lat: location.lat, lon: location.lon)
    }
    
    private func loadWeather(lat: Double, lon: Double) {
        homeVC.loadWeather(lat: lat, lon: lon)
        forecastVC.loadWeather(lat: lat, lon: lon)
        suggestionsVC.loadWeather(lat: lat, lon: lon)
    }
}
