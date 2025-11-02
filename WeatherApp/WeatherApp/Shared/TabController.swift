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
    }
    
    private func setupTabs() {
        // აქ იქნება 5-ვე ფეიჯი, ქვედა კოდი ნიმუშისთვის
//        let vc1 = WeatherViewController()
//        newsVC.tabBarItem = UITabBarItem(
//            title: "News",
//            image: UIImage(systemName: "text.rectangle.page"),
//            tag: 0
//        )
        
//        let vc2 = WeatherViewController()
//        appVC.tabBarItem = UITabBarItem(
//            title: "APPOTM",
//            image: UIImage(named: "RocketImage"),
//            tag: 1
//        )
        
//        tabBar.tintColor = .systemBlue
//        tabBar.backgroundColor = .clear
//        setViewControllers([vc, vc2], animated: false)
    }
    
    // ეს ხაზი გვექნება თუ არა გადასაწყვეტია
//    private func setupTopLine() {
//        tabBar.addSubview(topLineView)
//        
//        NSLayoutConstraint.activate([
//            topLineView.topAnchor.constraint(equalTo: tabBar.topAnchor),
//            topLineView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
//            topLineView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
//            topLineView.heightAnchor.constraint(equalToConstant: 0.4)
//        ])
//    }
}
