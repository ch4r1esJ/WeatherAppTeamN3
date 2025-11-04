import UIKit

class suggestionVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "defaultBackground")
        return imageView
    }()
    
    let img: UIImageView = {
        let img = UIImageView(image: UIImage(named: "img"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let locationImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "locationPin"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .gray
        return img
    }()
    
    let locationName: UILabel = {
        let locationName = UILabel()
        locationName.translatesAutoresizingMaskIntoConstraints = false
        locationName.font = .systemFont(ofSize: 20, weight: .medium)
        locationName.textColor = .white
        return locationName
    }()
    
    let temp: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = .systemFont(ofSize: 20, weight: .medium)
        temp.textColor = .white
        return temp
    }()
    
    let weatherBasedSuggestionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Weather-based Suggestions"
        label.textColor = .white
        return label
    }()
    
    let suggestionsTableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.backgroundColor = .clear
        tb.separatorStyle = .none
        tb.rowHeight = 60
        return tb
    }()
    
    var suggestArray: [String] = []
    
    private let viewModel = SuggestionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        view.backgroundColor = UIColor(red: 8/255, green: 36/255, blue: 79/255, alpha: 0.25)
        
        setupUI()
        configureConstraints()
        bindViewModel()
        
        viewModel.loadWeather(for: "Tbilisi")
    }
    
    private func setupUI() {
        view.addSubview(backgroundImageView)
        
        view.addSubview(locationImg)
        view.addSubview(img)
        view.addSubview(weatherBasedSuggestionLabel)
        view.addSubview(suggestionsTableView)
        view.addSubview(locationName)
        view.addSubview(temp)
        
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
            
            temp.centerYAnchor.constraint(equalTo: locationImg.centerYAnchor),
            temp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
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
        temp.text = viewModel.temperature
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
    
    // MARK: - TableView DataSource
    
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
