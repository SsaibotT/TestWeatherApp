//
//  CurrentConditionParams.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 08.02.2024.
//

import Foundation

class CurrentConditionParams: BaseRequestParams {
    
    init(language: String = LanguageKeys.en, details: Bool = false) {
        super.init([
            RequestParamsKeys.language: language,
            RequestParamsKeys.details: details
        ])
    }
}
