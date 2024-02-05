//
//  HourlyForecastService.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation
import RxSwift

class HourlyForecastService: DataResultService, HourlyForecastServiceProtocol {
    @Injected var apiClient: ApiClient
    
    func getHourlyForecast(locationKey: String) -> Observable<DataResult<[HourlyForecastRemote]>> {
        apiClient.procedure(api: ApiInfo.hourlyForecast(locationKey: locationKey), params: DailyForecastParams())
            .map { self.dataResult(ofType: [HourlyForecastRemote].self, from: $0) }
    }
}
