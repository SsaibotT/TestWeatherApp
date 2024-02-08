//
//  String+matchesRegexp.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 08.02.2024.
//

import Foundation

extension String {
    func matchesRegex(_ regex: String) -> Bool {
        return range(of: regex, options: .regularExpression) != nil
    }
}
