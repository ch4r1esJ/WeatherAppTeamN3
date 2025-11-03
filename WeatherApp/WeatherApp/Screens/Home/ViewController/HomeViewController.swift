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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundImage()
        setupView()
        registerCell()
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
        ])
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as? HomeCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
