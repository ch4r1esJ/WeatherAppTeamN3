//
//  ButtonExtension.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/2/25.
//

import UIKit

class RoundButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
}

extension UIButton {
    static func make(imageName: String) -> UIButton {
        let button = RoundButton()
        var config = UIButton.Configuration.plain()
        config.background.imageContentMode = .scaleAspectFill
        config.image = UIImage(named: imageName)
        config.baseForegroundColor = .label
        config.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7)
        button.configuration = config
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
