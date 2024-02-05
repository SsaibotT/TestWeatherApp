//
//  ForecastRepositoryProtocol.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation
import RxSwift

protocol ForecastRepositoryProtocol {
    func getHourlyForecast(locationKey: String) -> Observable<DataResult<[HourlyForecast]>>
}
