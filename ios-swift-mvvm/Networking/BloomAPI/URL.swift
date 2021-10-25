//
//  URL.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 20/10/21.
//

import Foundation

enum ApiUrl: String {
    
    case prod = "https://bloom-api.com"
    
    var convertedUrl: URL {
        guard let url = URL(string: self.rawValue) else {
            assertionFailure("Incorrect format of URL")
            return URL(string: "")!
        }
        return url
    }
    
}
