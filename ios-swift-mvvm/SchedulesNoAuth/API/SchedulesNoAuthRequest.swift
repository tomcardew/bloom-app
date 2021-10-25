//
//  FeaturedRequest.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 20/10/21.
//

import Foundation

struct SchedulesNoAuthRequest: APIRequest {
    
    var body: [String : Any]?
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
    var url: URL {
        ApiUrl.prod.convertedUrl
    }
    var path: ApiPath {
        .schedules
    }
    var queryTimes: [URLQueryItem]? {
        nil
    }
    var method: HTTPMethod {
        .post
    }
    var additionalPathParams: [String]? {
        []
    }
}
