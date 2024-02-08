//
//  ApiInfo.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 04.02.2024.
//

import Foundation

struct ApiInfo {
    
    static func dailyForecast(locationKey: String) -> ApiValue {
        .init(
            path: "/forecasts/v1/daily/1day/\(locationKey)",
            requestType: .get,
            header: .basicHeader
        )
    }
    
    static func hourlyForecast(locationKey: String) -> ApiValue {
        .init(
            path: "/forecasts/v1/hourly/12hour/\(locationKey)",
            requestType: .get,
            header: .basicHeader
        )
    }
    
    static var searchCityAutocomplete: ApiValue {
        .init(
            path: "/locations/v1/cities/autocomplete",
            requestType: .get,
            header: .basicHeader
        )
    }
    
    static func currentCondition(locationKey: String) -> ApiValue {
        .init(
            path: "/currentconditions/v1/\(locationKey)",
            requestType: .get,
            header: .basicHeader
        )
    }
}

private extension ApiValue {
    init(
        path: String,
        requestType: ApiReqeustType,
        header: ApiHeaderType
    ) {
        self.init(
            path: path,
            requestType: requestType,
            header: header,
            apiUrl: .mainEnv
        )
    }
}
