//
//  CurrentConditionRepositoryProtocol.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 08.02.2024.
//

import Foundation
import RxSwift

protocol CurrentConditionRepositoryProtocol {
    
    func getCurrentCondition(locationKey: String) -> Observable<DataResult<[CurrentCondition]>>
}
