//
//  ProfileRequest.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 08/11/21.
//

import Foundation

struct ProfileRequest: APIRequest {
    
    var url: URL {
        ApiUrl.prod.convertedUrl
    }
    
    var path: ApiPath {
        .me
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
