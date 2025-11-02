//
//  LabelExtension.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/2/25.
//

import UIKit

extension UILabel {
    static func make(
        text: String = "",
        fontSize: CGFloat,
        weight: UIFont.Weight,
        color: UIColor?,
        numberOfLines: Int = 1,
        alignment: NSTextAlignment = .left,
        alpha: CGFloat = 1
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: fontSize, weight: weight)
        label.textColor = color
        label.numberOfLines = numberOfLines
        label.textAlignment = alignment
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
