//
//  HourlyForecastRemote.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation

struct HourlyForecastRemote: Codable {
    let dateTime: String
    let epochDateTime, weatherIcon: Int
    let iconPhrase: String
    let hasPrecipitation: Bool
    let precipitationType, precipitationIntensity: String?
    let isDaylight: Bool
    let temperature: TemperatureRemote
    let precipitationProbability: Int
    let mobileLink, link: String

    enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
        case epochDateTime = "EpochDateTime"
        case weatherIcon = "WeatherIcon"
        case iconPhrase = "IconPhrase"
        case hasPrecipitation = "HasPrecipitation"
        case precipitationType = "PrecipitationType"
        case precipitationIntensity = "PrecipitationIntensity"
        case isDaylight = "IsDaylight"
        case temperature = "Temperature"
        case precipitationProbability = "PrecipitationProbability"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}

extension HourlyForecastRemote {
    static var empty: Self {
        .init(
            dateTime: "",
            epochDateTime: 0,
            weatherIcon: 0,
            iconPhrase: "",
            hasPrecipitation: false,
            precipitationType: nil,
            precipitationIntensity: nil,
            isDaylight: false,
            temperature: TemperatureRemote.empty,
            precipitationProbability: 0,
            mobileLink: "",
            link: ""
        )
    }
}

// MARK: - Temperature
struct TemperatureRemote: Codable {
    let value: Double
    let unit: UnitRemote
    let unitType: Int

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}

extension TemperatureRemote {
    static var empty: Self {
        .init(value: 0.0, unit: UnitRemote.c, unitType: 0)
    }
}

enum UnitRemote: String, Codable {
    case c = "C"
}
