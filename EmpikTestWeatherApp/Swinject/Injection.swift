//
//  Injection.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 04.02.2024.
//

import Foundation
import Swinject

final class Injection {
    static let shared = Injection()
    
    var container: Container {
        get {
            if let localContainer = localContainer {
                return localContainer
            } else {
                return buildContainer()
            }
        }
        set {
            localContainer = newValue
        }
    }
    
    private var localContainer: Container?
    
    private func buildContainer() -> Container {
        let container = Container()
        
        cityInfoContainer(container: container)
        forecastContainer(container: container)
        
        container.register(ApiClient.self) { _ in
            ApiClient()
        }
        
        return container
    }
    
    private func cityInfoContainer(container: Container) {
        container.register(CityInfoAutocompleteUseCaseProtocol.self) { _ in
            CityInfoAutocompleteUseCase()
        }
        
        container.register(CityInfoAutocompleteRepositoryProtocol.self) { _ in
            CityInfoAutocompleteRepository()
        }
        
        container.register(CityInfoAutocompleteServiceProtocol.self) { _ in
            CityInfoAutocompleteService()
        }
    }
    
    private func forecastContainer(container: Container) {
        container.register(HourlyForecastUseCaseProtocol.self) { _ in
            HourlyForecastUseCase()
        }
        
        container.register(ForecastRepositoryProtocol.self) { _ in
            ForecastRepository()
        }
        
        container.register(HourlyForecastServiceProtocol.self) { _ in
            HourlyForecastService()
        }
    }
}

@propertyWrapper struct Injected<Dependency> {
    let wrappedValue: Dependency
    
    init() {
        // let it crash, so you know that your object isn't registered
        self.wrappedValue = Injection.shared.container.resolve(Dependency.self)!
    }
}
