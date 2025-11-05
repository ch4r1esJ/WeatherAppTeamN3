//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Atinati on 02.11.25.
//

import UIKit
import Foundation

class ForecastCell: UITableViewCell {
    
    // MARK: Properties
    
    static let identifier = "ForecastCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(red: 8/255, green: 36/255, blue: 79/255, alpha: 0.25)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel: UILabel = .make(
        fontSize: 18,
        weight: .regular,
        color: .white
    )
    
    private let weatherIcon: UIImageView = {
        let view = UIImageView()
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tempLabel: UILabel = .make(
        fontSize: 18,
        weight: .semibold,
        color: .white,
        alignment: .right
    )
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupInitialStyles()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func setupInitialStyles() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        contentView.backgroundColor = .clear
        layer.shadowColor = UIColor(red: 0/255, green: 16/255, blue: 38/255, alpha: 1).cgColor
        layer.shadowOpacity = 0.50
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 16
        layer.masksToBounds = false
    }
    
    private func setupSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(dateLabel)
        containerView.addSubview(weatherIcon)
        containerView.addSubview(tempLabel)
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 16
        let iconSize: CGFloat = 50
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            dateLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            
            weatherIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            weatherIcon.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            weatherIcon.widthAnchor.constraint(equalToConstant: iconSize),
            weatherIcon.heightAnchor.constraint(equalToConstant: iconSize),
            
            tempLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
        ])
    }
    
    func configure(dateText: String, imageUrl: String, temperatureText: String) {
        dateLabel.text = dateText
        tempLabel.text = temperatureText
        loadWeatherIcon(from: imageUrl)
    }
    
    private func loadWeatherIcon(from imageUrl: String) {
        weatherIcon.image = nil
        weatherIcon.tintColor = .white
        
        guard let url = URL(string: imageUrl) else {
            weatherIcon.image = UIImage(systemName: "cloud.fill")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self,
                  let data = data,
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.weatherIcon.image = image
            }
        }.resume()
    }
}

