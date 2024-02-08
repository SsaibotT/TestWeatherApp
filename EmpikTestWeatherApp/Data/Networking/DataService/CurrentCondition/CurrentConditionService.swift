//
//  CurrentConditionService.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 08.02.2024.
//

import Foundation
import RxSwift

class CurrentConditionService: DataResultService, CurrentConditionServiceProtocol {
    @Injected var apiClient: ApiClient
    
    func getCurrentCondition(locationKey: String) -> Observable<DataResult<[CurrentConditionRemote]>> {
        apiClient.procedure(api: ApiInfo.currentCondition(locationKey: locationKey), params: CurrentConditionParams())
            .map { self.dataResult(ofType: [CurrentConditionRemote].self, from: $0) }
    }
}
