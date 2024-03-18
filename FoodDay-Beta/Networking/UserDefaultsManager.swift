//
//  UserDefaultsManager.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 26.02.2024.
//

import Foundation

class UserDefaultsManager {
    static var shared = UserDefaultsManager()
    
    var theme: Theme {
        get {
            Theme(rawValue: UserDefaults.standard.integer(forKey: "selectedTheme")) ?? .light
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "selectedTheme")
        }
    }
    
    
    
}
