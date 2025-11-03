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
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "defaultBackground")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel = UILabel.make(text: "Recommendations", fontSize: 16, weight: .light, color: .black)
    
    private let arrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
        let image = UIImage(systemName: "arrow.right", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        
        return button
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
        
        [locationView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            locationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

        ])
    }
}
