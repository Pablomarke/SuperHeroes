//
//  LocalDataModel.swift
//  SuperHeroes
//
//  Created by Pablo Márquez Marín on 19/9/23.
//

import Foundation

struct LocalDataModel {
    private static let key = "SuperHeroesToken"
    
    private static let userDefaults = UserDefaults.standard
    
    static func getToken() -> String? {
        userDefaults.string(forKey: key)
    }
    
    static func save(token: String) {
        userDefaults.set(token, forKey: key)
        
    }
    
    static func deleteToken() {
        userDefaults.removeObject(forKey: key)
    }
}
