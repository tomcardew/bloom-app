//
//  MainRequest.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 25/10/21.
//

import Foundation

struct MainRequest: APIRequest {
    
    var url: URL {
        ApiUrl.prod.convertedUrl
    }
    
    var path: ApiPath {
        .images
    }
    
    var body: [String : Any]? {
        nil
    }
    
    var additionalPathParams: [String]? {
        nil
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var queryTimes: [URLQueryItem]? {
        nil
    }
    
    
}
