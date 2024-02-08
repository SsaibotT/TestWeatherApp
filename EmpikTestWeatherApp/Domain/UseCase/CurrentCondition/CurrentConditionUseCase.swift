//
//  CurrentConditionUseCase.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 08.02.2024.
//

import Foundation
import RxSwift

struct CurrentConditionUseCase: CurrentConditionUseCaseProtocol {
    @Injected var repository: CurrentConditionRepositoryProtocol
    
    func getCurrentCondition(locationKey: String) -> Observable<DataResult<[CurrentCondition]>> {
        repository.getCurrentCondition(locationKey: locationKey)
    }
}
