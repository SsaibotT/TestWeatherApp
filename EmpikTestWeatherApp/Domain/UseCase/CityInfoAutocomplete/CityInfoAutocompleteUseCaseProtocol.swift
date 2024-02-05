//
//  CityInfoAutocompleteUseCaseProtocol.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation
import RxSwift

protocol CityInfoAutocompleteUseCaseProtocol {
    func getCityInfoAutocomplete(word: String) -> Observable<DataResult<[CityInfo]>>
}
