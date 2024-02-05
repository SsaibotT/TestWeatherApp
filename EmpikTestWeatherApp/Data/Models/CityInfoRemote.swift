//
//  CityInfoRemote.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation

struct CityInfoRemote: Codable {
    let version: Int
    let key, type: String
    let rank: Int
    let localizedName: String
    let country, administrativeArea: AdministrativeAreaRemote

    enum CodingKeys: String, CodingKey {
        case version = "Version"
        case key = "Key"
        case type = "Type"
        case rank = "Rank"
        case localizedName = "LocalizedName"
        case country = "Country"
        case administrativeArea = "AdministrativeArea"
    }
}

struct AdministrativeAreaRemote: Codable {
    let id, localizedName: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
    }
}
