//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Luka Ushikishvili on 11/4/25.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDataSource {

    private let viewModel = DetailsViewModel()
    private let tableView = UITableView()
    private let cityLabel = UILabel()
    private let weatherIcon = UIImageView()
    private let backgroundImageView = UIImageView()
    private let mapPinIcon = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.loadMockData()
    }

    private func setupUI() {
        backgroundImageView.image = UIImage(named: "defaultBackground")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)

        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        mapPinIcon.image = UIImage(named: "locationPin")
        mapPinIcon.contentMode = .scaleAspectFit
        mapPinIcon.translatesAutoresizingMaskIntoConstraints = false
        mapPinIcon.widthAnchor.constraint(equalToConstant: 22).isActive = true
        mapPinIcon.heightAnchor.constraint(equalToConstant: 22).isActive = true

        cityLabel.text = viewModel.cityName
        cityLabel.font = .boldSystemFont(ofSize: 20)
        cityLabel.textColor = .white
        cityLabel.translatesAutoresizingMaskIntoConstraints = false

        let cityStack = UIStackView(arrangedSubviews: [mapPinIcon, cityLabel])
        cityStack.axis = .horizontal
        cityStack.spacing = 6
        cityStack.alignment = .center
        cityStack.translatesAutoresizingMaskIntoConstraints = false

        weatherIcon.image = UIImage(named: viewModel.iconName)
        weatherIcon.contentMode = .scaleAspectFit
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(cityStack)
        view.addSubview(weatherIcon)

        NSLayoutConstraint.activate([
            cityStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cityStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            weatherIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            weatherIcon.heightAnchor.constraint(equalToConstant: 150),
            weatherIcon.widthAnchor.constraint(equalToConstant: 150)
        ])

        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(WeatherDetailCell.self, forCellReuseIdentifier: WeatherDetailCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.details.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailCell.identifier, for: indexPath) as? WeatherDetailCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.details[indexPath.row])
        return cell
    }
}

#Preview {
    DetailsViewController()
}
