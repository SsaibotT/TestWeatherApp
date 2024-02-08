//
//  LocationDetailsViewModel.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 06.02.2024.
//

import Foundation
import RxSwift
import RxRelay

class LocationDetailsViewModel {
    @Injected private var hourlyForecastUseCase: HourlyForecastUseCaseProtocol
    @Injected private var currentConditionsUseCase: CurrentConditionUseCaseProtocol
    private var disposeBag = DisposeBag()
    private var coordinator: MainCoordinator
    private var locationData: CityInfo
    
    // MARK: Output
    var currentConditionsTemperature = BehaviorRelay<String?>(value: nil)
    var currentConditionsWeather = BehaviorRelay<String?>(value: nil)
    var locationDataObservable = BehaviorRelay<CityInfo?>(value: nil)
    var hourlyForecast = BehaviorRelay<[HourlyForecast]>(value: [])
    
    // MARK: Actions
    var getLocationDetails = BehaviorRelay<Void>(value: ())
    
    // MARK: Lifecycle
    init(coordinator: MainCoordinator, locationData: CityInfo) {
        self.locationData = locationData
        self.coordinator = coordinator
        
        configureBindings()
        getDetails(locationKey: locationData.key)
        getCurrentConditions(locationKey: locationData.key)
        
        locationDataObservable.accept(locationData)
    }
    
    // MARK: Configuring
    private func configureBindings() {
        getLocationDetails
            .skip(1)
            .bind { [weak self] _ in
                guard let self = self else { return }
                self.getDetails(locationKey: self.locationData.key)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: Private methods
    private func getDetails(locationKey: String) {
        hourlyForecastUseCase.getHourlyForecast(locationKey: locationKey)
            .observe(on: MainScheduler.instance)
            .bind { [weak self] result in
                if let data = result.data {
                    self?.hourlyForecast.accept(data)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func getCurrentConditions(locationKey: String) {
        currentConditionsUseCase.getCurrentCondition(locationKey: locationKey)
            .observe(on: MainScheduler.instance)
            .bind { [weak self] result in
                if let data = result.data {
                    guard let locationData = data.first else { return }
                    let temperature = "\(locationData.temperature.temperature.value) \(locationData.temperature.temperature.unit)"
                    let weather = locationData.weatherText
                    
                    self?.currentConditionsTemperature.accept(temperature)
                    self?.currentConditionsWeather.accept(weather)
                }
            }
            .disposed(by: disposeBag)
    }
}
