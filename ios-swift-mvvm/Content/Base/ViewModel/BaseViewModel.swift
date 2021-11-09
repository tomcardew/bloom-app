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
        do {
            let user: User? = try DataManager.shared.get(key: .User)
            guard let user = user, let picture = user.pictureUrl else {
                throw ErrorResponse(code: 0, message: "User or profile picture not found")
            }
            if picture.isEmpty {
                return nil
            }
            return picture
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
