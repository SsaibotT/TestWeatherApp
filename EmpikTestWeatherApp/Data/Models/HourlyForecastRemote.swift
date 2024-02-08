//
//  HourlyForecastRemote.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation

struct HourlyForecastRemote: Codable {
    let dateTime: String
    let iconPhrase: String
    let temperature: TemperatureRemote

    enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
        case iconPhrase = "IconPhrase"
        case temperature = "Temperature"
    }
}

extension HourlyForecastRemote {
    static var empty: Self {
        .init(
            dateTime: "",
            iconPhrase: "",
            temperature: TemperatureRemote.empty
        )
    }
}

// MARK: - Temperature
struct TemperatureRemote: Codable {
    let value: Double
    let unit: UnitRemote

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
    }
}

extension TemperatureRemote {
    static var empty: Self {
        .init(value: 0.0, unit: UnitRemote.c)
    }
}

enum UnitRemote: String, Codable {
    case c = "C"
}
