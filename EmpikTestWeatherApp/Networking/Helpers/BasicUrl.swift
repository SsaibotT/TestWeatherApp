//
//  BasicUrl.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 04.02.2024.
//

import Foundation

enum BasicURL {
    case mainEnv
    
    var basicURL: String {
        switch self {
        case .mainEnv:
            return "http://dataservice.accuweather.com/"
        }
    }
}
