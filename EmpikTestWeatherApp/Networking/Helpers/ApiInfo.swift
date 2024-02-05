//
//  ApiInfo.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 04.02.2024.
//

import Foundation

struct Api {
    
    static func recipe(locationKey: Int) -> ApiValue {
        .init(
            path: "/forecasts/v1/daily/1day/\(locationKey)",
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
