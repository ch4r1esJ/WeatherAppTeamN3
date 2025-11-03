//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Gegi Ghvachliani on 03.11.25.
//

import UIKit

class CitiesViewController: UIViewController {
    
    // MARK: Properties
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = .defaultBackground

        return imageView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Add city", for: .normal)
        button.titleLabel?.textColor = .lightGray
        button.backgroundColor = .init(white: 0.4, alpha: 0.3)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.leftView = leftPadding
        textField.leftViewMode = .always
        
        let rightPadding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        textField.rightView = leftPadding
        textField.rightViewMode = .always
        
        textField.backgroundColor = .init(white: 0, alpha: 0.3)
        let placeholderText = "Search"
        let placeholderColor = UIColor.lightGray
        
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
        
        textField.textAlignment = .left
        textField.layer.cornerRadius = 15
        textField.clipsToBounds = true
        
        return textField
    }()
    
    private var citiesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.rowHeight = ScreenSize.height * (110 / 874)
        tableView.backgroundColor = .clear
        
        return tableView
    }()
    
    // MARK: Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        setupUI()
    }
    
    // MARK: Methods
    private func setupUI() {
        view.addSubview(backgroundImageView)
        view.addSubview(searchTextField)
        view.addSubview(addButton)
        view.addSubview(citiesTableView)
        
        configureTableView()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ScreenSize.width * (20 / 402)),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ScreenSize.width * (-20 / 402)),
            searchTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 25 / 402),

            addButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: ScreenSize.height * (10 / 874)),
            addButton.trailingAnchor.constraint(equalTo: searchTextField.trailingAnchor, constant: 0),
            addButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 100 / 404),
            addButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 35 / 404),
            
            citiesTableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: ScreenSize.height * (10 / 874)),
            citiesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0 /*ScreenSize.width * (20 / 402)*/),
            citiesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0/*ScreenSize.width * (-20 / 402)*/),
            citiesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureTableView() {
        citiesTableView.dataSource = self
        citiesTableView.delegate = self
        
        citiesTableView.register(CitiesTableViewCell.self, forCellReuseIdentifier: "FavouritesTableViewCell")
    }
}
 // TODO: შესაცლელია
extension CitiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesTableViewCell", for: indexPath) as? CitiesTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}

#Preview {
    CitiesViewController()
}
