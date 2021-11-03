//
//  ImagesResponse.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 25/10/21.
//

import Foundation

struct ImagesResponse: Codable {
    var success: Bool
    var data: [ImagesModel]?
    var error: ErrorResponse?
}
