//
//  BaseViewModel.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 08/11/21.
//

import Foundation

final class BaseViewModel {
    
    /// Initializer
    init() { }
    
    /// Public methods
    func getProfilePicture() -> String? {
        let user: User? = DataManager.shared.get(key: .User)
        return user?.pictureUrl
    }
    
}
