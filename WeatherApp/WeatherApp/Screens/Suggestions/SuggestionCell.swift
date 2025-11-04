import UIKit

class SuggestionCell: UITableViewCell {

     
    let suggestionTxt: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let bulletPoint: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.text = "•"
        label.textAlignment = .center
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        setupUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     
    private func setupUI() {
        contentView.addSubview(bulletPoint)
        contentView.addSubview(suggestionTxt)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            bulletPoint.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            bulletPoint.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bulletPoint.widthAnchor.constraint(equalToConstant: 20),
            
            suggestionTxt.leadingAnchor.constraint(equalTo: bulletPoint.trailingAnchor, constant: 5),
            suggestionTxt.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            suggestionTxt.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            suggestionTxt.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
  
    func configure(with suggestion: String) {
        suggestionTxt.text = suggestion
    }
}
