//
//  SearchCityViewController.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 04.02.2024.
//

import UIKit
import RxSwift
import RxCocoa

class SearchCityViewController: UIViewController {
    var viewModel: SearchCityViewModel
    var disposeBag = DisposeBag()
    
    // MARK: Views
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = ""
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: Lifecycle
    init(viewModel: SearchCityViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureObservables()
        configureConstraints()
        configureTableView()
    }
    
    // MARK: Configure TableView
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SearchCityCellIdentifier")
    }
    
    // MARK: Observables
    private func configureObservables() {
        viewModel.cities.bind { [weak self] cities in
            self?.tableView.reloadData()
        }
        .disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingChanged)
            .bind { [weak self] in
                guard let text = self?.textField.text else { return }
                let isValid = text.matchesRegex("^[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻа-яА-Я ]*$")
                if !isValid {
                    self?.textField.text?.removeLast()
                } else {
                    self?.textField.text = text
                }
            }
            .disposed(by: disposeBag)
        
        textField.rx.text
            .orEmpty
            .skip(1)
            .bind(to: viewModel.getCityInfoAutocomplete)
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .bind { [weak self] _ in
                self?.textField.text = ""
                self?.viewModel.cancelTapped.accept(())
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: Constraints
    private func configureConstraints() {
        view.addSubview(textField)
        view.addSubview(cancelButton)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            cancelButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cancelButton.widthAnchor.constraint(equalToConstant: 50),
            cancelButton.heightAnchor.constraint(equalTo: textField.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension SearchCityViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cities.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCityCellIdentifier", for: indexPath)
        let city = viewModel.cities.value[indexPath.row]
        cell.textLabel?.text = "\(city.localizedName), \(city.country.localizedName), \(city.administrativeArea.localizedName)"

        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension String {
    func matchesRegex(_ regex: String) -> Bool {
        return range(of: regex, options: .regularExpression) != nil
    }
}
