//
//  DataResult.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation

struct DataResult<T> {
    let data: T?
    let failure: ApiError?
}
