//
//  DataManager.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 04/11/21.
//

import Foundation
import Track

final class DataManager: Subscriber {
    
    static let shared: DataManager = DataManager()
    
    enum DataKeys: String {
        case User = "user"
        case Other = "other"
    }
    
    public func set<T>(object: T, key: DataKeys) {
        if let obj = object as? Encodable {
            Cache.shareInstance.set(object: obj.toJSONString()! as NSCoding, forKey: key.rawValue)
            self.notify()
        }
    }
    
    public func get<T: Decodable>(key: DataKeys) throws -> T {
        let data = Cache.shareInstance.object(forKey: key.rawValue) as! String
        return try JSONDecoder().decode(T.self, from: data.data(using: .utf8)!)
    }
        
}

extension Encodable {
    
    func toJSONData() -> Data? {
        try? JSONEncoder().encode(self)
    }
    
    func toJSONString() -> String? {
        try? String(data: self.toJSONData()!, encoding: .utf8)
    }
    
}
