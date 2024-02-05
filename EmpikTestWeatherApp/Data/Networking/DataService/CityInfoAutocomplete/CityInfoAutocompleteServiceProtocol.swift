//
//  CityInfoAutocompleteServiceProtocol.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation
import RxSwift

protocol CityInfoAutocompleteServiceProtocol {
    func getCityInfoAutocomplete(word: String) -> Observable<DataResult<[CityInfoRemote]>>
}
