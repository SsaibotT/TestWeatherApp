//
//  CurrentConditionRepository.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 08.02.2024.
//

import Foundation
import RxSwift

class CurrentConditionRepository: CurrentConditionRepositoryProtocol {
    @Injected var service: CurrentConditionServiceProtocol
    
    func getCurrentCondition(locationKey: String) -> Observable<DataResult<[CurrentCondition]>> {
        service.getCurrentCondition(locationKey: locationKey)
            .map { result in
                DataResult(
                    data: result.data?.map { CurrentCondition(from: $0) }.compactMap { $0 },
                    failure: result.failure ?? ApiError.noData
                )
            }
    }
}
