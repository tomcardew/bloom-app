//
//  KeyManager.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 03/11/21.
//

import Foundation

class KeyManager {
    
    enum Keys: String {
        case Token = "token"
    }
    
    public static func get<T>(key: Keys) -> T {
        return UserDefaults.standard.object(forKey: key.rawValue) as! T
    }
    
    public static func set(key: String, value: Any) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
}
