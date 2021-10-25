//
//  ErrorResponse.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 25/10/21.
//

import Foundation

struct ErrorResponse: Codable, Error, LocalizedError {
    let code: Int
    let message: String
    
    var errorDescription: String? {
        get {
            return message
        }
    }
}
