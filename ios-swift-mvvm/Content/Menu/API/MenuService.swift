//
//  MenuService.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 27/10/21.
//

import Foundation

final class MenuService {
    private let networkRequester: NetworkRequester
    private let request: NetworkRequest
    
    init(networkRequester: NetworkRequester = .init(), request: NetworkRequest = NetworkRequest(apiRequest: MenuRequest())) {
        self.networkRequester = networkRequester
        self.request = request
    }
    
    func getVersion(completionHandler: @escaping(Result<VersionResponse, Error>)->Void) {
        networkRequester.requestService(request: request, completion: { (result: Result<VersionResponse, Error>) in
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
