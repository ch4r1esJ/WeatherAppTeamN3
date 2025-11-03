//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/2/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let locationView = LocationView()
    private let infoView = InfoView()
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "defaultBackground")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        setupView()
    }
    
    // MARK: - Methods
    
    private func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.frame = view.bounds
    }
    
    private func setupView() {
        view.addSubview(locationView)
        view.addSubview(infoView)
        
        [locationView, infoView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            locationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            infoView.topAnchor.constraint(equalTo: locationView.bottomAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

