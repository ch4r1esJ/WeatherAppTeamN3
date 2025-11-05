//
//  HomeCell.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/3/25.
//

import UIKit

class HomeCell: UICollectionViewCell {
    // MARK: - Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 50/255, green: 120/255, blue: 200/255, alpha: 0.1)
        view.layer.cornerRadius = 25
        view.layer.cornerCurve = .continuous
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        return view
    }()
    
    private let timeLabel: UILabel = .make(
        fontSize: 15,
        weight: .medium,
        color: .white.withAlphaComponent(0.9),
        alignment: .center
    )
    
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let temperatureLabel: UILabel = .make(
        fontSize: 20,
        weight: .semibold,
        color: .white,
        alignment: .center
    )
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(timeLabel)
        containerView.addSubview(weatherIcon)
        containerView.addSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            timeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14),
            timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            timeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            weatherIcon.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            weatherIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            weatherIcon.widthAnchor.constraint(equalToConstant: 42),
            weatherIcon.heightAnchor.constraint(equalToConstant: 42),
            
            temperatureLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -14),
            temperatureLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            temperatureLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        ])
    }
    
    private func setupStyle() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 12
        layer.masksToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(
            roundedRect: containerView.frame,
            cornerRadius: 22
        ).cgPath
    }
    
    func configure(temperature: String, iconURL: String, time: String) {
        temperatureLabel.text = temperature
        timeLabel.text = time
        weatherIcon.image = UIImage(systemName: "cloud.fill")
        
        if let url = URL(string: iconURL) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data = data,
                      let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.weatherIcon.image = image
                }
            }.resume()
        }
    }
}
