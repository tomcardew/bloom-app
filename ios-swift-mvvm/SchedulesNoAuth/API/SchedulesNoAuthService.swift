//
//  FeaturedService.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 20/10/21.
//

import Foundation

final class SchedulesNoAuthService {
    
    private let networkRequester: NetworkRequester
    private let request: NetworkRequest
    
    init(networkRequester: NetworkRequester = .init(), request: NetworkRequest = NetworkRequest(apiRequest: SchedulesNoAuthRequest(body: ["start": "2021-10-25"]))) {
        self.networkRequester = networkRequester
        self.request = request
    }
    
    func getSchedules(completionHandler: @escaping(Result<SchedulesResponse, Error>)->Void) {
        networkRequester.requestService(request: request, completion: { (result: Result<SchedulesResponse, Error>) in
            switch result {
            case .success(let response):
                if response.success {
                    completionHandler(.success(response))
                } else {
                    completionHandler(.failure(response.error!))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        })
    }
}
