//
//  CityInfoAutocompleteRepository.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation
import RxSwift

class CityInfoAutocompleteRepository: CityInfoAutocompleteRepositoryProtocol {
    @Injected var service: CityInfoAutocompleteServiceProtocol
    
    func getCityInfoAutocomplete(word: String) -> Observable<DataResult<[CityInfo]>> {
        service.getCityInfoAutocomplete(word: word)
            .map { result in
                DataResult(
                    data: result.data?.map { CityInfo(from: $0) }.compactMap { $0 },
                    failure: result.failure ?? ApiError.noData
                )
            }
    }
}

