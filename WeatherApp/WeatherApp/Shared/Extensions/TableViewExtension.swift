//
//  TableViewExtension.swift
//  WeatherApp
//
//  Created by Atinati on 02.11.25.
//

import UIKit

extension UITableView {
    static func make(
        rowHeight: CGFloat,
        cornerRadius: CGFloat,
        isScrollEnabled: Bool,
        backgroundColor: UIColor = .clear
    ) -> UITableView {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = backgroundColor
        tableView.rowHeight = rowHeight
        tableView.layer.cornerRadius = cornerRadius
        tableView.clipsToBounds = true
        tableView.isScrollEnabled = isScrollEnabled
        tableView.translatesAutoresizingMaskIntoConstraints = true
        return tableView
    }
}
