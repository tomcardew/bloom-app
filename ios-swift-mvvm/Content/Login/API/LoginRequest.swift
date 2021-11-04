//
//  MainRequest.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 04/11/21.
//

import Foundation

struct LoginRequest: APIRequest {
    
    var url: URL {
        ApiUrl.prod.convertedUrl
    }
    
    var path: ApiPath {
        .login
    }
    
    var body: [String : Any]?
    
    var additionalPathParams: [String]? {
        nil
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    
    var queryTimes: [URLQueryItem]? {
        nil
    }
    
    
}
