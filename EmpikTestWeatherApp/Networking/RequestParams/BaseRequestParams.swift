//
//  BaseRequestParams.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 04.02.2024.
//

import Foundation

class BaseRequestParams {
    private(set) var parameters: [String: Any]

    internal init(_ parameters: [String: Any]) {
        self.parameters = parameters
        self.parameters[RequestParamsKeys.apiKey] = "gQotpC8NwfAQhN13yUBalKRikw3N7XB9"
    }
}
