//
//  CityInfoAutocompleteParams.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation

class CityInfoAutocompleteParams: BaseRequestParams {
    init(language: String = LanguageKeys.en, word: String) {
        super.init([
            RequestParamsKeys.q: word,
            RequestParamsKeys.language: language
        ])
    }
}
