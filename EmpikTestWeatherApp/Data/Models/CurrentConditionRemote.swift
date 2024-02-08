//
//  CurrentConditionRemote.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 08.02.2024.
//

import Foundation

struct CurrentConditionRemote: Codable {
    let localObservationDateTime: String
    let weatherText: String
    let temperature: CurrentTemperatureRemote

    enum CodingKeys: String, CodingKey {
        case localObservationDateTime = "LocalObservationDateTime"
        case weatherText = "WeatherText"
        case temperature = "Temperature"
    }
}

struct CurrentTemperatureRemote: Codable {
    let temperature: TemperatureValueRemote

    enum CodingKeys: String, CodingKey {
        case temperature = "Metric"
    }
}

struct TemperatureValueRemote: Codable {
    let value: Double
    let unit: String

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
    }
}
