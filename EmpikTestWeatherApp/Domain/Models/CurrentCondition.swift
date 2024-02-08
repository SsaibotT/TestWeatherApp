//
//  CurrentCondition.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 08.02.2024.
//

import Foundation

struct CurrentCondition {
    let localObservationDateTime: String
    let weatherText: String
    let temperature: CurrentTemperature
}

struct CurrentTemperature {
    let temperature: TemperatureValue
}

struct TemperatureValue {
    let value: Double
    let unit: String
}

extension CurrentCondition {
    init?(from remote: CurrentConditionRemote?) {
        guard let remote = remote else { return nil }
        self.init(
            localObservationDateTime: remote.localObservationDateTime,
            weatherText: remote.weatherText,
            temperature: CurrentTemperature(from: remote.temperature)
        )
    }
    
    static var empty: Self {
        .init(
            localObservationDateTime: "",
            weatherText: "",
            temperature: CurrentTemperature.empty)
    }
}

extension CurrentTemperature {
    init(from remote: CurrentTemperatureRemote) {
        self.init(temperature: TemperatureValue(from: remote.temperature))
    }
    
    static var empty: Self {
        .init(temperature: TemperatureValue.empty)
    }
}

extension TemperatureValue {
    init(from remote: TemperatureValueRemote) {
        self.init(
            value: remote.value,
            unit: remote.unit
        )
    }
    
    static var empty: Self {
        .init(
            value: 0.0,
            unit: ""
        )
    }
}
