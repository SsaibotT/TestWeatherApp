//
//  DataResultService.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation

class DataResultService {

    func entity<T: Codable>(ofType type: T.Type, from data: Data) -> T? {
        return try? JSONDecoder().decode(type, from: data)
    }

    func dataResult<T: Codable>(ofType type: T.Type, from response: ApiResult) -> DataResult<T> {
        switch response {
        case .success(let data):
            if let entity = entity(ofType: type, from: data) {
                return DataResult(data: entity, failure: nil)
            } else {
                return DataResult(data: nil, failure: .noData)
            }
        case .failure(let failure):
            return DataResult(data: nil, failure: .error(failure))
        }
    }
}
