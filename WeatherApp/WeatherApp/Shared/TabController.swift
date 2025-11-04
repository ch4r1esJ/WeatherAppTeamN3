//
//  TabBar.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/1/25.
//
import UIKit

class TabController: UITabBarController {
    // დავამატე გვერდების ინსტანსები
    private var homeVC: HomeViewController!
    private var forecastVC: ForecastViewController!
    private var citiesVC: CitiesViewController!
    
    private let topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupTabBarAppearance()
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
        
         citiesVC = CitiesViewController()
        citiesVC.tabBarItem = UITabBarItem(
            title: "Cities",
            image: UIImage(systemName: "plus.circle"),
            tag: 1
        )
        
        citiesVC.onCitySelected = { [weak self] weatherInfo in
                    self?.handleCitySelection(weatherInfo)
                }
        // აქ დაამატეთ თქვენი ფეიჯი
        
        setViewControllers([homeVC, forecastVC, citiesVC], animated: true) // აქ თანმიმდევრობის მიხედვით ჩაამატეთ თქვენი ფეიჯი
    }
    
    private func handleCitySelection(_ weatherInfo: WeatherFirstInfo) {
            // Update HomeViewController
            homeVC.loadWeather(lat: weatherInfo.lat, lon: weatherInfo.lon)
            
            // Update ForecastViewController
            forecastVC.loadWeather(lat: weatherInfo.lat, lon: weatherInfo.lon)
            
            // Switch to Home tab
            selectedIndex = 0 // Home is at index 0
        }
}
