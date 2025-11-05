//
//  SuggestionViewController.swift
//  WeatherApp
//
//  Created by Demna Koridze on 04.11.25.
//

import UIKit

class SuggestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let viewModel = SuggestionViewModel()
    private var suggestions: [String] = []
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "defaultBackground")
        return imageView
    }()
    
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "img"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let locationIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "locationPin"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .gray
        return imageView
    }()
    
    private let locationName: UILabel = .make(
        fontSize: 20,
        weight: .medium,
        color: .white
    )
    
    private let temperature: UILabel = .make(
        fontSize: 20,
        weight: .medium,
        color: .white
    )
    
    private let sectionLabel: UILabel = .make(
        text: "Weather-based Suggestions",
        fontSize: 20,
        weight: .semibold,
        color: .white
    )
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 8/255, green: 36/255, blue: 79/255, alpha: 0.25)
        setupUI()
        setupConstraints()
        bindViewModel()
    }
    
    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(locationIcon)
        view.addSubview(weatherIcon)
        view.addSubview(sectionLabel)
        view.addSubview(tableView)
        view.addSubview(locationName)
        view.addSubview(temperature)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SuggestionCell.self, forCellReuseIdentifier: "SuggestionCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            locationIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            locationIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            locationIcon.widthAnchor.constraint(equalToConstant: 24),
            locationIcon.heightAnchor.constraint(equalToConstant: 24),
            
            locationName.centerYAnchor.constraint(equalTo: locationIcon.centerYAnchor),
            locationName.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 5),
            
            temperature.centerYAnchor.constraint(equalTo: locationIcon.centerYAnchor),
            temperature.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            weatherIcon.topAnchor.constraint(equalTo: locationIcon.bottomAnchor, constant: 20),
            weatherIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherIcon.widthAnchor.constraint(equalToConstant: 120),
            weatherIcon.heightAnchor.constraint(equalToConstant: 120),
            
            sectionLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 30),
            sectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
    private func bindViewModel() {
        viewModel.onWeatherLoaded = { [weak self] _ in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
    }
    
    private func updateUI() {
        locationName.text = viewModel.cityName
        temperature.text = viewModel.temperature
        suggestions = viewModel.getSuggestions()
        backgroundImageView.image = UIImage(named: viewModel.backgroundAssetName)
        weatherIcon.image = UIImage(named: viewModel.weatherIconName)
        tableView.reloadData()
    }
    
    func loadWeather(lat: Double, lon: Double) {
        viewModel.loadWeather(lat: lat, lon: lon)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        suggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionCell", for: indexPath) as? SuggestionCell else {
            return UITableViewCell()
        }
        cell.configure(with: suggestions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
