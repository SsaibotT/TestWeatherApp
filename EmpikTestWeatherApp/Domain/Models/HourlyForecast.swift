//
//  HourlyForecast.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation

struct HourlyForecast {
    let dateTime: String
    let epochDateTime, weatherIcon: Int
    let iconPhrase: String
    let hasPrecipitation: Bool
    let precipitationType, precipitationIntensity: String?
    let isDaylight: Bool
    let temperature: Temperature
    let precipitationProbability: Int
    let mobileLink, link: String
}

struct Temperature {
    let value: Double
    let unit: Unit
    let unitType: Int
}

struct Unit {
    let c = "C"
}

extension HourlyForecast {
    init?(from remote: HourlyForecastRemote?) {
        guard let remote = remote else { return nil }
        self.init(
            dateTime: remote.dateTime,
            epochDateTime: remote.epochDateTime,
            weatherIcon: remote.weatherIcon,
            iconPhrase: remote.iconPhrase,
            hasPrecipitation: remote.hasPrecipitation,
            precipitationType: remote.precipitationType,
            precipitationIntensity: remote.precipitationIntensity,
            isDaylight: remote.isDaylight,
            temperature: Temperature(from: remote.temperature),
            precipitationProbability: remote.precipitationProbability,
            mobileLink: remote.mobileLink,
            link: remote.link
        )
    }
    
    static func empty() -> Self {
        .init(
            dateTime: "",
            epochDateTime: 0,
            weatherIcon: 0,
            iconPhrase: "",
            hasPrecipitation: false,
            precipitationType: nil,
            precipitationIntensity: nil,
            isDaylight: false,
            temperature: Temperature.empty(),
            precipitationProbability: 0,
            mobileLink: "",
            link: ""
        )
    }
}

extension Temperature {
    init(from remote: TemperatureRemote) {
        self.init(
            value: remote.value,
            unit: Unit(),
            unitType: remote.unitType
        )
    }
    
    static func empty() -> Self {
        .init(value: 0.0, unit: Unit(), unitType: 0)
    }
}
