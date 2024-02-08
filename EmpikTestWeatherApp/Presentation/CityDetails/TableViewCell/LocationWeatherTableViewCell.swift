//
//  LocationWeatherTableViewCell.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 08.02.2024.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    static var identifier = "CurrentConditionsCellIdentifier"
    
    // MARK: Views
    let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .darkGray
        
        return label
    }()
    
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .darkGray
        
        return label
    }()
    
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration
    private func configureConstraints() {
        bottomStackView.addArrangedSubview(temperatureLabel)
        bottomStackView.addArrangedSubview(weatherLabel)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(bottomStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            bottomStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bottomStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Public Methods
    func configure(title: String, temperature: String, weather: String, temperatureColor: UIColor) {
        titleLabel.text = title
        temperatureLabel.text = temperature
        weatherLabel.text = weather
        temperatureLabel.textColor = temperatureColor
    }
}
