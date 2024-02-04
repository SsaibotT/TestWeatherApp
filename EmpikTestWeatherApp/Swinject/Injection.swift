//
//  Injection.swift
//  EmpikTestWeatherApp
//
//  Created by Serhii Semenov on 04.02.2024.
//

import Foundation
import Swinject

final class Injection {
    static let shared = Injection()
    
    var container: Container {
        get {
            if let localContainer = localContainer {
                return localContainer
            } else {
                return buildContainer()
            }
        }
        set {
            localContainer = newValue
        }
    }
    
    private var localContainer: Container?
    
    private func buildContainer() -> Container {
        let container = Container()
        
        return container
    }
}

@propertyWrapper struct Injected<Dependency> {
    let wrappedValue: Dependency
    
    init() {
        // let it crash, so you know that your object isn't registered
        self.wrappedValue = Injection.shared.container.resolve(Dependency.self)!
    }
}
