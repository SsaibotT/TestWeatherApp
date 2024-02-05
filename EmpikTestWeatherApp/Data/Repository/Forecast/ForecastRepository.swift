//
//  ForecastRepository.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation
import RxSwift

class ForecastRepository: ForecastRepositoryProtocol {
    @Injected var forecastService: HourlyForecastServiceProtocol
    
    func getHourlyForecast(locationKey: String) -> Observable<DataResult<[HourlyForecast]>> {
        forecastService.getHourlyForecast(locationKey: locationKey)
            .map { result in
                DataResult(
                    data: result.data?.map { HourlyForecast(from: $0) ?? HourlyForecast.empty() },
                    failure: result.failure ?? ApiError.noData
                )
            }
    }
}
