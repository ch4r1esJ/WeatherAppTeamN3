//
//  CityView.swift
//  WeatherApp
//
//  Created by Atinati on 03.11.25.
//

import UIKit

class CityView: UIView {
    private let hStack = UIStackView.make(axis: .horizontal, distribution: .fill, alignment: .center, spacing: 8)
    
    private let cityName = UILabel.make(text: "", fontSize: 17, weight: .bold, color: .white)
    
    private let locationPin: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "locationPin")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let weatherImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "thunderstormIcon")
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        addSubview(hStack)
        addSubview(weatherImage)
        
        [locationPin, cityName].forEach { hStack.addArrangedSubview($0) }
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStack.heightAnchor.constraint(equalToConstant: 24),
            locationPin.widthAnchor.constraint(equalToConstant: 20),
            locationPin.heightAnchor.constraint(equalToConstant: 20),
            
            weatherImage.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 16),
            weatherImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherImage.widthAnchor.constraint(equalToConstant: 200),
            weatherImage.heightAnchor.constraint(equalToConstant: 200),
            weatherImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func configure(city: String, iconName: String) {
        let parts = city.split(separator: ",")
        let cleanedCity = parts.last?.trimmingCharacters(in: .whitespacesAndNewlines) ?? city
        cityName.text = cleanedCity
        weatherImage.image = UIImage(named: iconName)
    }
}
