//
//  CityInfo.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 05.02.2024.
//

import Foundation

struct CityInfo {
    let version: Int
    let key, type: String
    let rank: Int
    let localizedName: String
    let country, administrativeArea: AdministrativeArea
}

extension CityInfo {
    init?(from remote: CityInfoRemote?) {
        guard let remote = remote else { return nil }
        self.init(
            version: remote.version,
            key: remote.key,
            type: remote.type,
            rank: remote.rank,
            localizedName: remote.localizedName,
            country: AdministrativeArea(from: remote.country),
            administrativeArea: AdministrativeArea(from: remote.administrativeArea)
        )
    }
    
    static var empty: Self {
        .init(
            version: 0,
            key: "",
            type: "",
            rank: 0,
            localizedName: "",
            country: AdministrativeArea.empty,
            administrativeArea: AdministrativeArea.empty
        )
    }
}

struct AdministrativeArea {
    let id, localizedName: String
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
