//
//  DailyForecastParams.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 04.02.2024.
//

import Foundation

class DailyForecastParams: BaseRequestParams {
    init(language: String = LanguageKeys.en, details: Bool = true, isMetric: Bool = true) {
        super.init([
            RequestParamsKeys.language: language,
            RequestParamsKeys.details: details,
            RequestParamsKeys.metric: isMetric
        ])
    }
}
