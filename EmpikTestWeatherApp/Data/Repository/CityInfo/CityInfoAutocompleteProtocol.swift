//
//  CityInfoAutocompleteRepositoryProtocol.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation
import RxSwift

protocol CityInfoAutocompleteRepositoryProtocol {
    func getCityInfoAutocomplete(word: String) -> Observable<DataResult<[CityInfo]>>
}
