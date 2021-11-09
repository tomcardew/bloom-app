//
//  InternalNotificationsManager.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 08/11/21.
//

import Foundation

class InternalNotificationsManager {
    
    enum Notifications: String {
        case CURRENT_USER_UPDATED
    }
    
    static func post(name: Notifications, object: Any?) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name.rawValue), object: object)
    }
    
    static func get(target: Any, selector: Selector, name: Notifications, object: Any?) {
        NotificationCenter.default.addObserver(target, selector: selector, name: NSNotification.Name(rawValue: name.rawValue), object: object)
    }
    
    static func remove(target: Any, name: Notifications, object: Any?) {
        NotificationCenter.default.removeObserver(target, name: NSNotification.Name(rawValue: name.rawValue), object: object)
    }
    
}
