//
//  HourlyForecast.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation

struct HourlyForecast {
    let dateTime: String
    let iconPhrase: String
    let temperature: Temperature
}

struct Temperature {
    let value: Double
    let unit: Unit
}

struct Unit {
    let c = "C"
}

extension HourlyForecast {
    init?(from remote: HourlyForecastRemote?) {
        guard let remote = remote else { return nil }
        self.init(
            dateTime: remote.dateTime,
            iconPhrase: remote.iconPhrase,
            temperature: Temperature(from: remote.temperature)
        )
    }
    
    static var empty: Self {
        .init(
            dateTime: "",
            iconPhrase: "",
            temperature: Temperature.empty
        )
    }
}

extension Temperature {
    init(from remote: TemperatureRemote) {
        self.init(
            value: remote.value,
            unit: Unit()
        )
    }
    
    static var empty: Self {
        .init(value: 0.0, unit: Unit())
    }
}

extension HourlyForecast {
    var convertedDateTime: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

        if let date = dateFormatter.date(from: dateTime) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "HH:mm"
            outputDateFormatter.timeZone = TimeZone(identifier: "GMT+1")

            let outputDateString = outputDateFormatter.string(from: date)
            
            return outputDateString
        }
        
        return nil
    }
}
