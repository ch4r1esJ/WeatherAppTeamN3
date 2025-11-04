//
//  WeatherDetailCell.swift
//  WeatherApp
//
//  Created by Luka Ushikishvili on 11/4/25.
//

import UIKit

class WeatherDetailCell: UITableViewCell {
    // MARK: UI Components
    
    static let identifier = "WeatherDetailCell"
    
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let stack = UIStackView()
    
    // MARK: Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInitialStyles()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialStyles() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.backgroundColor = .clear
        layer.shadowColor = UIColor(red: 0/255, green: 16/255, blue: 38/255, alpha: 1).cgColor
        layer.shadowOpacity = 0.99
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 16
        layer.masksToBounds = false
    }
    
    // MARK: Methods
    
    private func setupLayout() {
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = .systemFont(ofSize: 18, weight: .regular)
        valueLabel.font = .systemFont(ofSize: 18, weight: .regular)
        
        titleLabel.textColor = .white
        valueLabel.textColor = .white
        
        let backgroundCard = UIView()
        backgroundCard.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        backgroundCard.layer.cornerRadius = 14
        backgroundCard.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundCard.addSubview(stack)
        contentView.addSubview(backgroundCard)
        
        NSLayoutConstraint.activate([
            backgroundCard.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            backgroundCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            backgroundCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backgroundCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            stack.topAnchor.constraint(equalTo: backgroundCard.topAnchor, constant: 12),
            stack.bottomAnchor.constraint(equalTo: backgroundCard.bottomAnchor, constant: -12),
            stack.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -16)
        ])
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(valueLabel)
    }
    
    func configure(with detail: WeatherDetail) {
        titleLabel.text = detail.title
        valueLabel.text = detail.value
    }
}
