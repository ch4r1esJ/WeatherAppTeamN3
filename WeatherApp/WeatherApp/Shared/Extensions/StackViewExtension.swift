//
//  StackViewExtension.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/2/25.
//

import UIKit

extension UIStackView {
    static func make(
        axis: NSLayoutConstraint.Axis,
        distribution: UIStackView.Distribution,
        alignment: UIStackView.Alignment,
        spacing: CGFloat = 0
    ) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.spacing = spacing
        stackView.alignment = alignment
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}
