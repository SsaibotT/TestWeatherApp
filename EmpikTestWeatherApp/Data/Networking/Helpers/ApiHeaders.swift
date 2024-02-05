//
//  ApiHeaders.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 04.02.2024.
//

import Foundation

typealias ApiHeaders = [String: String]?

struct ApiHeader {
    private static let ContentType = "Content-Type"
    private static let AppJson = "application/json"
    
    static var basicHeader: ApiHeaders {
        [ContentType: AppJson]
    }
}
