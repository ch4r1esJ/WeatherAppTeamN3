//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Atinati on 02.11.25.
//
import UIKit

class ForecastViewController: UIViewController {
    
    // MARK: UI
    
    private let cityView = CityView()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let forecastTitleLabel: UILabel = UILabel.make(
        text: " 🗓️ 6 - DAY FORECAST",
        fontSize: 20,
        weight: .medium,
        color: .white,
        alignment: .left,
        alpha: 0.9,
    )
    
    private let tableView: UITableView = {
        let tableView = UITableView.make(
            rowHeight: 80,
            cornerRadius: 16,
            isScrollEnabled: true
        )
        return tableView
    }()
    
    // MARK: ViewModel
    
    private let viewModel = ForecastViewModel()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupUI()
        setupViewModelCallbacks()
        viewModel.loadForecast()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutTableAndHeaderFrame()
    }
    
    // MARK: Setup
    
    private func setupUI() {
        setupTableView()
        addSubviews()
        setupLayoutConstraints()
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
    
    private func layoutTableAndHeaderFrame() {
        let tableHeight: CGFloat = 6 * 80
        let tableY = view.bounds.midY - (tableHeight / 2) + 120
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

    private func setupLayoutConstraints() {
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
    
    
    // MARK: ViewModel Binding
    
    private func setupViewModelCallbacks() {
        viewModel.onUpdate = { [weak self] in
            self?.refreshUIWithViewModel()
        }
    }
    
    private func refreshUIWithViewModel() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.backgroundImageView.image = self.viewModel.backgroundImage()
            self.weatherImageView.image = self.viewModel.weatherIconImage()
            self.cityView.configure(city: self.viewModel.currentCityName,
            weatherIcon: self.viewModel.weatherIconImage())
        }
    }
    // MARK: დავამატე ლოკაციით ინფოს ჩამოტვირტვა
    func loadWeather(lat: Double, lon: Double) {
           viewModel.loadForecast(lat: lat, lon: lon)
       }
}

// MARK: UITableViewDataSource / UITableViewDelegate

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ForecastCell.identifier,
            for: indexPath
        ) as? ForecastCell else {
            return UITableViewCell()
        }
        
        let item = viewModel.item(at: indexPath.row)
        
        cell.configure(
            dateText: item.dateText,
            imageUrl: item.imageUrl,
            temperatureText: item.temperatureText
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

#Preview {
    ForecastViewController()
}
