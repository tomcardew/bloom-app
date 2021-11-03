//
//  MenuRequest.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 27/10/21.
//

import Foundation

struct MenuRequest: APIRequest {
    
    var url: URL {
        ApiUrl.prod.convertedUrl
    }
    
    var path: ApiPath {
        .version
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
