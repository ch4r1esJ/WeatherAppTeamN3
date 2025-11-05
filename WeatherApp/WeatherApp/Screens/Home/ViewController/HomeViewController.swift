//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/2/25.
//

import UIKit

class HomeViewController: UIViewController {
    private let locationView = LocationView()
    private let infoView = InfoView()
    private let viewModel = HomeViewModel()
    
    private let todaySectionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let todayLabel: UILabel = .make(
        text: "TODAY",
        fontSize: 13,
        weight: .semibold,
        color: .white.withAlphaComponent(0.7)
    )
    
    private let detailsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Details", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        
        let config = UIImage.SymbolConfiguration(pointSize: 13, weight: .medium)
        let image = UIImage(systemName: "chevron.right", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    private let forecastContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 0, height: 12)
        view.layer.shadowRadius = 24
        return view
    }()
    
    private let forecastList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: 80, height: 140)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor(red: 8/255, green: 36/255, blue: 79/255, alpha: 0.25)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "defaultBackground")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        setupViews()
        setupCollectionView()
        setupActions()
        bindViewModel()
    }
    
    private func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.frame = view.bounds
    }
    
    private func setupCollectionView() {
        forecastList.register(HomeCell.self, forCellWithReuseIdentifier: "HomeCell")
        forecastList.dataSource = self
        forecastList.delegate = self
    }
    
    private func setupViews() {
        view.addSubview(locationView)
        view.addSubview(infoView)
        view.addSubview(todaySectionView)
        view.addSubview(forecastContainer)
        forecastContainer.addSubview(forecastList)
        todaySectionView.addSubview(todayLabel)
        todaySectionView.addSubview(detailsButton)
        
        [locationView, infoView, forecastList].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            locationView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            infoView.topAnchor.constraint(equalTo: locationView.bottomAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            todaySectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            todaySectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            todaySectionView.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 30),
            todaySectionView.heightAnchor.constraint(equalToConstant: 24),
            
            todayLabel.leadingAnchor.constraint(equalTo: todaySectionView.leadingAnchor, constant: 20),
            todayLabel.centerYAnchor.constraint(equalTo: todaySectionView.centerYAnchor),
            
            detailsButton.trailingAnchor.constraint(equalTo: todaySectionView.trailingAnchor),
            detailsButton.centerYAnchor.constraint(equalTo: todaySectionView.centerYAnchor),
            detailsButton.heightAnchor.constraint(equalToConstant: 32),
            
            forecastContainer.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            forecastContainer.trailingAnchor.constraint(equalTo: infoView.trailingAnchor),
            forecastContainer.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 60),
            forecastContainer.heightAnchor.constraint(equalToConstant: 150),
            
            forecastList.topAnchor.constraint(equalTo: forecastContainer.topAnchor),
            forecastList.leadingAnchor.constraint(equalTo: forecastContainer.leadingAnchor),
            forecastList.trailingAnchor.constraint(equalTo: forecastContainer.trailingAnchor),
            forecastList.bottomAnchor.constraint(equalTo: forecastContainer.bottomAnchor),
        ])
    }
    
    private func setupActions() {
        detailsButton.addAction(UIAction { [weak self] _ in
            guard let self = self,
                  let coord = self.viewModel.weatherResponse?.city.coord else { return }
            let detailsVC = DetailsViewController()
            detailsVC.lat = coord.lat
            detailsVC.lon = coord.lon
            self.present(detailsVC, animated: true)
        }, for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel.onWeatherLoaded = { [weak self] _ in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
    }
    
    private func updateUI() {
        locationView.configure(city: viewModel.cityName, iconName: viewModel.weatherIconName)
        infoView.configure(temperature: viewModel.temperature, max: viewModel.maxTemp, min: viewModel.minTemp)
        backgroundImage.image = UIImage(named: viewModel.backgroundAssetName)
        forecastList.reloadData()
    }
    
    func loadWeather(lat: Double, lon: Double) {
        viewModel.loadWeather(lat: lat, lon: lon)
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfForecastItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as? HomeCell else {
            return UICollectionViewCell()
        }
        let item = viewModel.forecastItem(at: indexPath.row)
        cell.configure(temperature: item.temp, iconURL: item.iconURL, time: item.time)
        return cell
    }
}

