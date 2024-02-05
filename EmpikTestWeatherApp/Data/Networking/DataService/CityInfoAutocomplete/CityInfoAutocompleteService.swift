//
//  CityInfoAutocompleteService.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation
import RxSwift

class CityInfoAutocompleteService: DataResultService, CityInfoAutocompleteServiceProtocol {
    @Injected var apiClient: ApiClient
    
    func getCityInfoAutocomplete(word: String) -> Observable<DataResult<[CityInfoRemote]>> {
        apiClient.procedure(api: ApiInfo.searchCityAutocomplete, params: CityInfoAutocompleteParams(word: word))
            .map { self.dataResult(ofType: [CityInfoRemote].self, from: $0) }
    }
}
