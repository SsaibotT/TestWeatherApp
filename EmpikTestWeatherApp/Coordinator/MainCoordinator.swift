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
        let searchCityViewModel = SearchCityViewModel(coordinator: self)
        let searchCityViewController = SearchCityViewController(viewModel: searchCityViewModel)
        
        navigationController.pushViewController(searchCityViewController, animated: false)
    }
    
    func locationDetailsScreen(locationData: CityInfo) {
        let locationDetailsViewModel = LocationDetailsViewModel(coordinator: self, locationData: locationData)
        let locationDetailsViewController = LocationDetailsViewController(viewModel: locationDetailsViewModel)
        
        navigationController.pushViewController(locationDetailsViewController, animated: true)
    }
}
