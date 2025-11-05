//
//  SuggestionViewController.swift
//  WeatherApp
//
//  Created by Demna Koridze on 04.11.25.
//

import UIKit

class SuggestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    // MARK: Methods
    private let backgroundImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "defaultBackground")
        return imageView
    }()
    
    let img: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "img"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let locationImg: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "locationPin"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .gray
        return imageView
    }()
    
    let locationName: UILabel = .make(
        fontSize: 20,
        weight: .medium,
        color: .white
    )
    
    let temperature: UILabel = .make(
        fontSize: 20,
        weight: .medium,
        color: .white
    )
    
    let weatherBasedSuggestionLabel: UILabel = .make(
        text: "Weather-based Suggestions",
        fontSize: 20,
        weight: .semibold,
        color: .white
    )
    
    let suggestionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        return tableView
    }()
    
    var suggestArray: [String] = []
    
    private let viewModel = SuggestionViewModel()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 8/255, green: 36/255, blue: 79/255, alpha: 0.25)
        setupUI()
        configureConstraints()
        bindViewModel()
        viewModel.loadWeather(for: "Tsqaltubo")
    }
    
    // MARK: Methods
    
    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(locationImg)
        view.addSubview(img)
        view.addSubview(weatherBasedSuggestionLabel)
        view.addSubview(suggestionsTableView)
        view.addSubview(locationName)
        view.addSubview(temperature)
        
        suggestionsTableView.dataSource = self
        suggestionsTableView.delegate = self
        suggestionsTableView.register(SuggestionCell.self, forCellReuseIdentifier: "SuggestionCell")
        suggestionsTableView.rowHeight = UITableView.automaticDimension
        suggestionsTableView.estimatedRowHeight = 60
        suggestionsTableView.backgroundColor = .clear
        
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            locationImg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            locationImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            locationImg.widthAnchor.constraint(equalToConstant: 24),
            locationImg.heightAnchor.constraint(equalToConstant: 24),
            
            locationName.centerYAnchor.constraint(equalTo: locationImg.centerYAnchor),
            locationName.leadingAnchor.constraint(equalTo: locationImg.trailingAnchor, constant: 5),
            
            temperature.centerYAnchor.constraint(equalTo: locationImg.centerYAnchor),
            temperature.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            img.topAnchor.constraint(equalTo: locationImg.bottomAnchor, constant: 20),
            img.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            img.widthAnchor.constraint(equalToConstant: 120),
            img.heightAnchor.constraint(equalToConstant: 120),
            
            weatherBasedSuggestionLabel.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 30),
            weatherBasedSuggestionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            suggestionsTableView.topAnchor.constraint(equalTo: weatherBasedSuggestionLabel.bottomAnchor, constant: 15),
            suggestionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            suggestionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            suggestionsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
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
        suggestArray = viewModel.getSuggestions()
        
        if let backgroundImg = viewModel.backgroundImage() {
            backgroundImageView.image = backgroundImg
        }
        
        if let weatherIcon = UIImage(named: viewModel.weatherIconName) {
            img.image = weatherIcon
        }
        suggestionsTableView.reloadData()
    }
    
    func loadWeather(lat: Double, lon: Double) {
        viewModel.loadWeather(lat: lat, lon: lon)
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionCell", for: indexPath) as? SuggestionCell else {
            return UITableViewCell()
        }
        
        let suggestion = suggestArray[indexPath.row]
        cell.configure(with: suggestion)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
