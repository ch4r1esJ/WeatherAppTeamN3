//
//  SuggestionCell.swift
//  WeatherApp
//
//  Created by Demna Koridze on 04.11.25.
//

import UIKit

class SuggestionCell: UITableViewCell {
    
    private let containerForCell: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = ScreenSize.width * (20 / 402)
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 8/255, green: 36/255, blue: 79/255, alpha: 0.25)
        return view
    }()
    
    let suggestionTxt: UILabel = .make(
        fontSize: 16,
        weight: .regular,
        color: .white,
        numberOfLines: 0
    )
    
    let bulletPoint: UILabel = .make(
        text: "•",
        fontSize: 16,
        weight: .regular,
        color: .white,
        alignment: .center
    )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        setupUI()
        setupInitialStyles()
        configureConstraints()
    }
    
    // MARK: Init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func setupUI() {
        contentView.addSubview(containerForCell)
        containerForCell.addSubview(bulletPoint)
        containerForCell.addSubview(suggestionTxt)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            containerForCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerForCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            containerForCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            containerForCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            bulletPoint.leadingAnchor.constraint(equalTo: containerForCell.leadingAnchor, constant: 10),
            bulletPoint.topAnchor.constraint(equalTo: containerForCell.topAnchor, constant: 15),
            bulletPoint.widthAnchor.constraint(equalToConstant: 20),
            
            suggestionTxt.leadingAnchor.constraint(equalTo: bulletPoint.trailingAnchor, constant: 5),
            suggestionTxt.trailingAnchor.constraint(equalTo: containerForCell.trailingAnchor, constant: -10),
            suggestionTxt.topAnchor.constraint(equalTo: containerForCell.topAnchor, constant: 15),
            suggestionTxt.bottomAnchor.constraint(equalTo: containerForCell.bottomAnchor, constant: -15)
        ])
    }
    
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
    
    func configure(with suggestion: String) {
        suggestionTxt.text = suggestion
    }
}
