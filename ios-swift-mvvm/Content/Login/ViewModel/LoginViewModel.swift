//
//  LoginViewModel.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 04/11/21.
//

import Foundation

final class LoginViewModel {
    
    /// Model status
    enum Status {
        case initial
        case loading
        case loggedIn
        case failed(String)
    }
    
    /// Properties
    private let service: LoginService
    
    var updateStatusHandler: ((Status) -> Void)?
    
    var currentState: Status = .initial {
        didSet {
            updateStatusHandler?(currentState)
        }
    }
    
    /// Initializer
    init(service: LoginService = .init()) {
        self.service = service
    }
    
    /// Public methods
    func login(email: String, password: String) {
        
        switch currentState {
        case .loading:
            return
        default:
            break
        }
        
        currentState = .loading
        
        service.login(email: email, password: password, completionHandler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                DataManager.shared.set(object: data.user!, key: .User)
                KeyManager.set(key: .Token, value: data.token!)
                self.currentState = .loggedIn
            case .failure(let error):
                self.currentState = .failed(error.localizedDescription)
            }
        })
    }
    
}
