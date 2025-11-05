//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Atinati on 02.11.25.
//

import UIKit

class ForecastViewController: UIViewController {
    private let cityView = CityView()
    private let viewModel = ForecastViewModel()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let forecastTitleLabel: UILabel = UILabel.make(
        text: " 6 - DAY FORECAST",
        fontSize: 20,
        weight: .medium,
        color: .white,
        alignment: .left,
        alpha: 0.9
    )
    
    private let tableView: UITableView = {
        let tableView = UITableView.make(
            rowHeight: 80,
            cornerRadius: 16,
            isScrollEnabled: true
        )
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupUI()
        bindViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTableAndHeader()
    }
    
    private func setupUI() {
        setupTableView()
        addSubviews()
        setupConstraints()
    }
    
    private func setupTableView() {
        tableView.register(ForecastCell.self, forCellReuseIdentifier: ForecastCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func addSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(cityView)
        view.addSubview(forecastTitleLabel)
        view.addSubview(tableView)
    }
    
    private func layoutTableAndHeader() {
        let tableHeight: CGFloat = 6 * 80
        let tableY = view.bounds.midY - (tableHeight / 2) + 170
        tableView.frame = CGRect(
            x: 16,
            y: tableY,
            width: view.bounds.width - 32,
            height: tableHeight
        )
        forecastTitleLabel.frame = CGRect(
            x: tableView.frame.origin.x,
            y: tableView.frame.origin.y - 28,
            width: view.bounds.width,
            height: 20
        )
    }
    
    private func setupConstraints() {
        cityView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cityView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cityView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cityView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            self?.updateUI()
        }
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            self.cityView.configure(city: self.viewModel.currentCityName, iconName: self.viewModel.weatherIconName)
            self.backgroundImageView.image = UIImage(named: self.viewModel.backgroundAssetName)
            self.tableView.reloadData()
        }
    }
    
    func loadWeather(lat: Double, lon: Double) {
        viewModel.loadForecast(lat: lat, lon: lon)
    }
}

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ForecastCell.identifier,
            for: indexPath
        ) as? ForecastCell else {
            return UITableViewCell()
        }
        
        let item = viewModel.item(at: indexPath.row)
        cell.configure(dateText: item.dateText, imageUrl: item.imageUrl, temperatureText: item.temperatureText)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
