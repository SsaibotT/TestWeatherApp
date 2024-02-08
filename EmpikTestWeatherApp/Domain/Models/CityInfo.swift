//
//  CityInfo.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation

struct CityInfo: Codable {
    let key: String
    let localizedName: String
    let country, administrativeArea: AdministrativeArea
}

struct AdministrativeArea: Codable {
    let id, localizedName: String
}

extension CityInfo {
    init?(from remote: CityInfoRemote?) {
        guard let remote = remote else { return nil }
        self.init(
            key: remote.key,
            localizedName: remote.localizedName,
            country: AdministrativeArea(from: remote.country),
            administrativeArea: AdministrativeArea(from: remote.administrativeArea)
        )
    }
    
    static var empty: Self {
        .init(
            key: "",
            localizedName: "",
            country: AdministrativeArea.empty,
            administrativeArea: AdministrativeArea.empty
        )
    }
}

extension AdministrativeArea {
    init(from remote: AdministrativeAreaRemote) {
        self.init(
            id: remote.id,
            localizedName: remote.localizedName
        )
    }
    
    static var empty: Self {
        .init(id: "", localizedName: "")
    }
}
