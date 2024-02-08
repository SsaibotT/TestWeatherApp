//
//  LocationDetailsViewController.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 06.02.2024.
//

import UIKit
import RxSwift

class LocationDetailsViewController: UIViewController {
    var viewModel: LocationDetailsViewModel
    var disposeBag = DisposeBag()
    
    // MARK: Views
    let headerTrailingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let headerLeadingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let cityNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.text = ""
        return label
    }()
    
    let cityNameAreaLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = ""
        return label
    }()
    
    let temperatureAreaLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.text = ""
       return label
    }()
    
    let weatherTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.text = ""
       return label
    }()
    
    let todayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.text = "Today"
        label.translatesAutoresizingMaskIntoConstraints = false
        
       return label
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: Lifecycle
    init(viewModel: LocationDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureObservables()
        configureConstraints()
        configureTableView()
    }
    
    // MARK: Configuration
    private func configureUI() {
        title = "Weather"
        view.backgroundColor = .white
    }
    
    private func configureObservables() {
        Observable.combineLatest(viewModel.locationDataObservable, viewModel.currentConditionsTemperature, viewModel.currentConditionsWeather)
            .skip(1)
            .bind { [weak self] locationData, temperature, weathertext in
                if let locationData = locationData {
                    self?.cityNameLabel.text = locationData.localizedName
                    self?.cityNameAreaLabel.text = "\(locationData.country.localizedName), \(locationData.administrativeArea.localizedName)"
                    self?.temperatureAreaLabel.text = "\(temperature?.value ?? 0.0) \(temperature?.unit.c ?? "C")"
                    self?.weatherTextLabel.text = weathertext
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.currentConditionsTemperature
            .map { $0?.temperatureColor ?? .black }
            .bind(to: temperatureAreaLabel.rx.textColor)
            .disposed(by: disposeBag)
        
        viewModel.hourlyForecast
            .bind { [weak self] _ in
                self?.tableView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
    }
    
    private func configureConstraints() {
        headerLeadingStackView.addArrangedSubview(cityNameLabel)
        headerLeadingStackView.addArrangedSubview(cityNameAreaLabel)
        
        headerTrailingStackView.addArrangedSubview(temperatureAreaLabel)
        headerTrailingStackView.addArrangedSubview(weatherTextLabel)
        
        view.addSubview(headerLeadingStackView)
        view.addSubview(headerTrailingStackView)
        view.addSubview(todayLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            headerLeadingStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerLeadingStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            headerTrailingStackView.centerYAnchor.constraint(equalTo: headerLeadingStackView.centerYAnchor),
            headerTrailingStackView.leadingAnchor.constraint(equalTo: headerLeadingStackView.trailingAnchor, constant: 20),
            headerTrailingStackView.heightAnchor.constraint(equalTo: headerLeadingStackView.heightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            todayLabel.topAnchor.constraint(equalTo: headerLeadingStackView.bottomAnchor, constant: 20),
            todayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: todayLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension LocationDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.hourlyForecast.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            fatalError("Failed to dequeue CustomTableViewCell")
        }
            
        let hourlyForecats = viewModel.hourlyForecast.value[indexPath.row]
        cell.configure(
            title: "\(hourlyForecats.convertedDateTime ?? "00:00")",
            temperature: "\(hourlyForecats.temperature.value) \(hourlyForecats.temperature.unit.c)",
            weather: "\(hourlyForecats.iconPhrase)",
            temperatureColor: hourlyForecats.temperature.temperatureColor
        )

        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
