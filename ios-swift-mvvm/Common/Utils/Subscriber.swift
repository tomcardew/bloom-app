//
//  Subscriber.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 04/11/21.
//

import Foundation

class Subscriber {
    
    var state: Int = { return Int(arc4random_uniform(10)) }()
    
    private lazy var observers = [Observer]()
    
    func attach(_ observer: Observer) {
        observers.append(observer)
        print(observers)
    }
    
    func detach(_ observer: Observer) {
        if let idx = observers.firstIndex(where: { $0 === observer }) {
            observers.remove(at: idx)
        }
    }
    
    func notify() {
        print("WILL NOTIFY")
        observers.forEach({ $0.update(subscriber: self) })
    }
    
}

protocol Observer: AnyObject {
    
    func update(subscriber: Subscriber)
    
}
