//
//  FavouritesTableViewCell.swift
//  WeatherApp
//
//  Created by Gegi Ghvachliani on 03.11.25.
//

import UIKit

class CitiesTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    private let containerForCell: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = ScreenSize.width * ( 20 / 402 )
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 8/255, green: 36/255, blue: 79/255, alpha: 0.25)
        return view
    }()
    
    private let temperatureLabel: UILabel = .make(
        text: "20º",
        fontSize: 45,
        weight: .semibold,
        color: .white,
        alignment: .center
    )
    
    private let cityLabel: UILabel = .make(
        text: "Tbilisi",
        fontSize: 35,
        weight: .medium,
        color: .white
    )
    
    // MARK: Life Cycles
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerForCell)
        containerForCell.addSubview(cityLabel)
        containerForCell.addSubview(temperatureLabel)
        setupConstraints()
        setupInitialStyles()
    }
    
    // MARK: Methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerForCell.topAnchor.constraint(equalTo: topAnchor),
            containerForCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.height * (-15 / 874)),
            containerForCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            containerForCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant:  -15),
            
            cityLabel.leadingAnchor.constraint(equalTo: containerForCell.leadingAnchor, constant: 15),
            cityLabel.centerYAnchor.constraint(equalTo: containerForCell.centerYAnchor),
            cityLabel.widthAnchor.constraint(equalTo: containerForCell.widthAnchor, multiplier: 3/5),
            
            temperatureLabel.trailingAnchor.constraint(equalTo: containerForCell.trailingAnchor, constant: -15),
            temperatureLabel.centerYAnchor.constraint(equalTo: containerForCell.centerYAnchor),
            temperatureLabel.widthAnchor.constraint(equalTo: containerForCell.widthAnchor, multiplier: 2/5)
        ])
    }
    
    private func setupInitialStyles() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        contentView.backgroundColor = .clear
        layer.shadowColor = UIColor(red: 0/255, green: 16/255, blue: 38/255, alpha: 1).cgColor
        layer.shadowOpacity = 0.9
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 16
        layer.masksToBounds = false
    }
    
    func configure(with weatherInfo: WeatherFirstInfo) {
        cityLabel.text = weatherInfo.name
        temperatureLabel.text = "\(Int(weatherInfo.temp))º"
    }
}
