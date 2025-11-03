//
//  TabBar.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/1/25.
//
import UIKit

class TabController: UITabBarController {
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
        
        let forecastVC = ForecastViewController()
        forecastVC.tabBarItem = UITabBarItem(
            title: "Forecast",
            image: UIImage(systemName: "cloud.sun"),
            tag: 0
        )
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: 1
        )
        
        // აქ დაამატეთ თქვენი ფეიჯი
        
        setViewControllers([homeVC, forecastVC], animated: true) // აქ თანმიმდევრობის მიხედვით ჩაამატეთ თქვენი ფეიჯი
    }
}
