//
//  CityInfoAutocompleteUseCase.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation
import RxSwift

struct CityInfoAutocompleteUseCase: CityInfoAutocompleteUseCaseProtocol {
    @Injected var repository: CityInfoAutocompleteRepositoryProtocol
    
    func getCityInfoAutocomplete(word: String) -> Observable<DataResult<[CityInfo]>> {
        repository.getCityInfoAutocomplete(word: word)
    }
}
