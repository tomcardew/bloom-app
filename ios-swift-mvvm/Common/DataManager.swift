//
//  DataManager.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 04/11/21.
//

import Foundation
import Track

final class DataManager {
    
    static let shared: DataManager = DataManager()
    
    enum DataKeys: String, CaseIterable {
        case User
        case Token
        case Other
    }
    
    public func setString(string: String, key: DataKeys) {
        Cache.shareInstance.set(object: string as NSCoding, forKey: key.rawValue)
    }
    
    public func set<T>(object: T?, key: DataKeys) {
        if let obj = object as? Encodable {
            Cache.shareInstance.set(object: obj.toJSONString()! as NSCoding, forKey: key.rawValue)
            notify(key: key)
        } else {
            Cache.shareInstance.removeObject(forKey: key.rawValue)
        }
    }
    
    public func remove(key: DataKeys) {
        Cache.shareInstance.removeObject(forKey: key.rawValue)
        notify(key: key)
    }
    
    public func get<T: Decodable>(key: DataKeys) -> T? {
        let data = Cache.shareInstance.object(forKey: key.rawValue) as? String
        if let data = data {
            do {
                return try JSONDecoder().decode(T.self, from: data.data(using: .utf8)!)
            } catch {
                print(error)
            }
        }
        return nil
    }
    
    public func getString(key: DataKeys) -> String? {
        let data = Cache.shareInstance.object(forKey: key.rawValue) as? String
        guard let data = data else { return nil }
        return data
    }
    
    public func deleteAll() {
        Cache.shareInstance.removeAllObjects()
        for key in DataKeys.allCases {
            notify(key: key)
        }
    }
    
    private func notify(key: DataKeys) {
        switch key {
        case .User :
            InternalNotificationsManager.post(name: .CURRENT_USER_UPDATED, object: nil)
        default:
            break
        }
    }
    
}

extension Encodable {
    
    func toJSONData() -> Data? {
        try? JSONEncoder().encode(self)
    }
    
    func toJSONString() -> String? {
        String(data: self.toJSONData()!, encoding: .utf8)
    }
    
}
