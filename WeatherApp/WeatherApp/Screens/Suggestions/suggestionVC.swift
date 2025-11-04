import UIKit

class suggestionVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let img: UIImageView = {
        let img = UIImageView(image: UIImage(named: "img"))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let locationImg: UIImageView = {
        let img = UIImageView(image: UIImage(named: "locationImg"))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let locationName: UILabel = {
        let locationName = UILabel()
        locationName.translatesAutoresizingMaskIntoConstraints = false
        locationName.font = .systemFont(ofSize: 20)
        return locationName
    }()
    
    let temp: UILabel = {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = .systemFont(ofSize: 20)
         
        return temp
    }()
    
    
    let weatherBasedSuggestionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.text = "Weather-based Suggestions"
        return label
    }()
    
    let suggestionsTableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    
    var suggestArray: [String] = []
    let suggestionManager = SuggestionManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        if let backImg = UIImage(named: "background") {
            view.backgroundColor = UIColor(patternImage: backImg)
        }
        
        setupUI()
        configureConstraints()
        loadSuggestions()
    }
    
     
    private func setupUI() {
        view.addSubview(locationImg)
        view.addSubview(img)
        view.addSubview(weatherBasedSuggestionLabel)
        view.addSubview(suggestionsTableView)
        view.addSubview(locationName)
        view.addSubview(temp)
        locationName.text = "Tbilisi"
        temp.text = "19 C"
        
        
        suggestionsTableView.dataSource = self
        suggestionsTableView.delegate = self
        suggestionsTableView.register(SuggestionCell.self, forCellReuseIdentifier: "SuggestionCell")
        suggestionsTableView.rowHeight = UITableView.automaticDimension
        suggestionsTableView.estimatedRowHeight = 60
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            locationImg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            locationName.topAnchor.constraint(equalTo: locationImg.topAnchor),
            locationName.leadingAnchor.constraint(equalTo: locationImg.trailingAnchor, constant: 5),
             
            temp.topAnchor.constraint(equalTo: locationImg.topAnchor),
            temp.leadingAnchor.constraint(equalTo: locationName.trailingAnchor, constant: 5),
            
            img.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            img.leadingAnchor.constraint(equalTo: temp.trailingAnchor, constant: 5),
            img.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            img.bottomAnchor.constraint(equalTo: weatherBasedSuggestionLabel.topAnchor, constant: 20),
        
            weatherBasedSuggestionLabel.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 20),
            weatherBasedSuggestionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weatherBasedSuggestionLabel.bottomAnchor.constraint(equalTo: suggestionsTableView.topAnchor, constant: -20),
            
            suggestionsTableView.topAnchor.constraint(equalTo: view.centerYAnchor),
            suggestionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            suggestionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            suggestionsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
        ])
    }
    
    private func loadSuggestions() {
        
        let testWeatherCode = "10"
        suggestArray = suggestionManager.getSuggestions(for: testWeatherCode)
        suggestionsTableView.reloadData()
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
