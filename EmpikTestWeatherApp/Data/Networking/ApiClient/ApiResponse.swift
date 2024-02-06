//
//  ApiResponse.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 04.02.2024.
//

import Foundation

enum ApiResult {
    case success(Data)
    case failure(ApiError)
}

enum ApiError: Error {
    case error(Error)
    case badRequest
    case noData
    case undefined
    case limitedResponse
}
