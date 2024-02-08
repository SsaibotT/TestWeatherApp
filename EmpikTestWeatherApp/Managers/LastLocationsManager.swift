//
//  LastLocationsManager.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 08.02.2024.
//

import Foundation

class LastLocationsManager {
    func save(locationData: CityInfo) {
        var locations = getLastLocations() ?? []
        locations.append(locationData)
        
        do {
            let encoder = PropertyListEncoder()
            let encodedData = try encoder.encode(locations)
            UserDefaults.standard.set(encodedData, forKey: "locationData")
            
            UserDefaults.standard.synchronize()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    func getLastLocations() -> [CityInfo]? {
        if let encodedData = UserDefaults.standard.data(forKey: "locationData") {
            do {
                let decoder = PropertyListDecoder()
                let decodedData = try decoder.decode([CityInfo].self, from: encodedData)
                
                return decodedData.reversed()
            } catch {
                print("\(error.localizedDescription)")
                return nil
            }
        }
        
        return nil
    }
}
