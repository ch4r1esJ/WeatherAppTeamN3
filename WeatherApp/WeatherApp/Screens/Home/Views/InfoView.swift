//
//  InfoView.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/3/25.
//

import UIKit

class InfoView: UIView {
    // MARK: - Properties
    
    private let temperatureLabel: UILabel = .make(
        text: "24ºC",
        fontSize: 80,
        weight: .bold,
        color: .white,
        alignment: .center
    )
    
    private let precipitationsLabel: UILabel = .make(
        text: "Precipitations",
        fontSize: 19,
        weight: .medium,
        color: .white,
        alignment: .center
    )
    
    private let maxMinLabel: UILabel = .make(
        text: "Max.: 25º Min.: 12º",
        fontSize: 19,
        weight: .medium,
        color: .white,
        alignment: .center
    )
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(temperatureLabel)
        addSubview(precipitationsLabel)
        addSubview(maxMinLabel)
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 1),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 15),
            
            precipitationsLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 8),
            precipitationsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            maxMinLabel.topAnchor.constraint(equalTo: precipitationsLabel.bottomAnchor, constant: 8),
            maxMinLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            maxMinLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func configure(temperature: String, max: String, min: String) {
        temperatureLabel.text = temperature
        maxMinLabel.text = "Max.: \(max)º Min.: \(min)º"
    }
}
