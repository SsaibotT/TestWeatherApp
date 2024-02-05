//
//  ApiHeaderType.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 04.02.2024.
//

import Foundation

enum ApiHeaderType {
    case basicHeader
    
    var header: ApiHeaders {
        switch self {
        case .basicHeader:
            return ApiHeader.basicHeader
        }
    }
}
