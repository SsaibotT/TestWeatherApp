//
//  Temperature.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 08.02.2024.
//

import Foundation
import UIKit

struct Temperature {
    let value: Double
    let unit: Unit
}

struct Unit {
    let c = "C"
}

extension Temperature {
    init(from remote: TemperatureValueRemote) {
        self.init(
            value: remote.value,
            unit: Unit()
        )
    }
    
    init(from remote: TemperatureRemote) {
        self.init(
            value: remote.value,
            unit: Unit()
        )
    }
    
    static var empty: Self {
        .init(
            value: 0.0,
            unit: Unit()
        )
    }
}

extension Temperature {
    var temperatureColor: UIColor {
        if value < 10.0 {
            return UIColor.blue
        } else if value >= 10.0 && value <= 20.0 {
            return UIColor.black
        } else if value > 20 {
            return UIColor.red
        }
        
        return .black
    }
}
