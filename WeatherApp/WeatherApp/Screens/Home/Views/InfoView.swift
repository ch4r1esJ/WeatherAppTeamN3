//
//  InfoView.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/3/25.
//

import UIKit

class InfoView: UIView {
    // MARK: - Properties
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 80, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "24ºC"
        return label
    }()
    
    private let precipitationsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        label.text = "Precipitations"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let maxMinLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "Max.: 25º Min.: 12º"
        return label
    }()
    
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
