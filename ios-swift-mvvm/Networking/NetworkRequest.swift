//
//  NetworkRequest.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 20/10/21.
//

import Foundation
import UIKit

struct NetworkRequest {
    var request: URLRequest
    
    init(apiRequest: APIRequest, useAuthorization: Bool = true) {
        var urlComponents = URLComponents(string: apiRequest.url.description)
        urlComponents?.path = apiRequest.path.rawValue
        urlComponents?.queryItems = apiRequest.queryTimes
        
        guard let fullURL = urlComponents?.url else {
            assertionFailure("Couldn't build the URL")
            self.request = URLRequest(url: URL(string: "")!)
            return
        }
        
        self.request = URLRequest(url: fullURL)
        self.request.httpMethod = apiRequest.method.rawValue
        
        if let body = apiRequest.body {
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            self.request.httpBody = jsonData
        }
        
        if let headers = apiRequest.headers {
            for header in headers {
                self.request.setValue(header.value, forHTTPHeaderField: header.key)
            }
        }
        
        let apikey: String? = KeyManager.get(key: .Token)
        if apikey != nil && useAuthorization {
            self.request.setValue(apikey, forHTTPHeaderField: "Authorization")
        }
        
    }
}
