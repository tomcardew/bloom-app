//
//  LoginService.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 04/11/21.
//

import Foundation

final class LoginService {
    
    private let networkRequester: NetworkRequester
    private let request: NetworkRequest
    
    init(networkRequester: NetworkRequester = .init(), request: NetworkRequest = NetworkRequest(apiRequest: LoginRequest())) {
        self.networkRequester = networkRequester
        self.request = request
    }
    
    func login(email: String, password: String, completionHandler: @escaping(Result<LoginResponse, Error>)->Void) {
        networkRequester.requestService(request: NetworkRequest(apiRequest: LoginRequest(body: ["email": email, "password": password])), completion: { (result: Result<LoginResponse, Error>) in
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
