//
//  ForecastRepository.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation
import RxSwift

class ForecastRepository: ForecastRepositoryProtocol {
    @Injected var service: HourlyForecastServiceProtocol
    
    func getHourlyForecast(locationKey: String) -> Observable<DataResult<[HourlyForecast]>> {
        service.getHourlyForecast(locationKey: locationKey)
            .map { result in
                DataResult(
                    data: result.data?.map { HourlyForecast(from: $0) }.compactMap { $0 },
                    failure: result.failure ?? ApiError.noData
                )
            }
    }
}
