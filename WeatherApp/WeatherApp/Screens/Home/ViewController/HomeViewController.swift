//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Charles Janjgava on 11/2/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let locationView = LocationView()
    private let infoView = InfoView()
    private let homeViewModel = HomeViewModel()
        
    private let forecastList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: 70, height: 130)

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.systemCyan.withAlphaComponent(0.3)
        view.layer.cornerRadius = 20
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
    
    private let titleLabel = UILabel.make(text: "Recommendations", fontSize: 16, weight: .light, color: .black)
    
    private let arrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
        let image = UIImage(systemName: "arrow.right", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        setupView()
        registerCell()
        configure()
        homeViewModel.loadWeather(for: "Tbilisi")
        
        homeViewModel.onWeatherLoaded = { [weak self] _ in
                DispatchQueue.main.async {
                    self?.configure()
                    self?.forecastList.reloadData()
                }
            }
    }
    
    // MARK: - Methods
    
    private func setupBackgroundImage() {
        view.addSubview(backgroundImage)
        backgroundImage.frame = view.bounds
    }
    
    private func registerCell() {
        forecastList.register(HomeCell.self, forCellWithReuseIdentifier: "HomeCell")
        forecastList.dataSource = self
        forecastList.delegate = self
    }
    
    private func setupView() {
        view.addSubview(locationView)
        view.addSubview(infoView)
        view.addSubview(forecastList)
        view.addSubview(titleLabel)
        view.addSubview(arrowButton)
        
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

            forecastList.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            forecastList.trailingAnchor.constraint(equalTo: infoView.trailingAnchor),
            forecastList.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 60),
            forecastList.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.centerYAnchor.constraint(equalTo: arrowButton.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: arrowButton.leadingAnchor, constant: -5),
            
            arrowButton.topAnchor.constraint(equalTo: forecastList.bottomAnchor, constant: 10),
            arrowButton.trailingAnchor.constraint(equalTo: forecastList.trailingAnchor),
            arrowButton.widthAnchor.constraint(equalToConstant: 44),
            arrowButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    func configure() {
        locationView.configure(city: homeViewModel.cityName)
        infoView.configure(temperature: homeViewModel.temperature, max: homeViewModel.max, min: homeViewModel.min)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.numberOfForecastItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as? HomeCell else {
            return UICollectionViewCell()
        }
        
        let forecast = homeViewModel.forecastItem(at: indexPath.row)
            cell.configure(temperature: forecast.temperature, icon: forecast.icon, time: forecast.time)
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    
    // MARK: დავამატე ლოკაციით ინფოს ჩამოტვირთვა
    func loadWeather(lat: Double, lon: Double) {
         homeViewModel.loadWeather(lat: lat, lon: lon)
     }
}
