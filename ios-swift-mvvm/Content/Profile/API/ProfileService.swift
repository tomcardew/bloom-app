//
//  ProfileService.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 08/11/21.
//

import Foundation

final class ProfileService {
    
    private let networkRequester: NetworkRequester
    private let request: NetworkRequest
    
    init(networkRequester: NetworkRequester = .init(), request: NetworkRequest = NetworkRequest(apiRequest: ProfileRequest())) {
        self.networkRequester = networkRequester
        self.request = request
    }
    
    func getMe(completionHandler: @escaping(Result<MeResponse, Error>)->Void) {
        networkRequester.requestService(request: request, completion: { (result: Result<MeResponse, Error>) in
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
