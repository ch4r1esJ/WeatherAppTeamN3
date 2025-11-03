//
//  HomeCell.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/3/25.
//

import UIKit

class HomeCell: UICollectionViewCell {
    // MARK: - Properties
    
    private let temperatureLabel = UILabel.make(text: "29°C", fontSize: 15, weight: .medium, color: .white)
    
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cloudIcon")
        return imageView
    }()
    
    private let timeLabel = UILabel.make(text: "15:00", fontSize: 15, weight: .regular, color: .white)

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(weatherIcon)
        contentView.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            weatherIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherIcon.widthAnchor.constraint(equalToConstant: 44),
            weatherIcon.heightAnchor.constraint(equalToConstant: 44),

            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
        
    func configure(temperature: String, icon: UIImage?, time: String) {
        temperatureLabel.text = temperature
        weatherIcon.image = icon
        timeLabel.text = time
    }
}

#Preview {
    HomeCell()
}
