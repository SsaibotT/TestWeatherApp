//
//  MainCoordinator.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 04.02.2024.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let searchCityViewController = SearchCityViewController()
        searchCityViewController.coordinator = self
        navigationController.pushViewController(searchCityViewController, animated: false)
    }
}
