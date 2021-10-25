//
//  MainService.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 25/10/21.
//

import Foundation

final class MainService {
    
    private let networkRequester: NetworkRequester
    private let request: NetworkRequest
    
    init(networkRequester: NetworkRequester = .init(), request: NetworkRequest = NetworkRequest(apiRequest: MainRequest())) {
        self.networkRequester = networkRequester
        self.request = request
    }
    
    func getImages(completionHandler: @escaping(Result<ImagesResponse, Error>)->Void) {
        networkRequester.requestService(request: request, completion: { (result: Result<ImagesResponse, Error>) in
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
