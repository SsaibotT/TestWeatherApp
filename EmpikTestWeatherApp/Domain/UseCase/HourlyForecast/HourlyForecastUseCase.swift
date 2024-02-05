//
//  HourlyForecastUseCase.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation
import RxSwift

struct HourlyForecastUseCase: HourlyForecastUseCaseProtocol {
    @Injected var repository: ForecastRepositoryProtocol
    
    func getHourlyForecast(locationKey: String) -> Observable<DataResult<[HourlyForecast]>> {
        repository.getHourlyForecast(locationKey: locationKey)
    }
}
