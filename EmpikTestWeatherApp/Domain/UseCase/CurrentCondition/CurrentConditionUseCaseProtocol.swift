//
//  CurrentConditionUseCaseProtocol.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 08.02.2024.
//

import Foundation
import RxSwift

protocol CurrentConditionUseCaseProtocol {
    
    func getCurrentCondition(locationKey: String) -> Observable<DataResult<[CurrentCondition]>>
}
