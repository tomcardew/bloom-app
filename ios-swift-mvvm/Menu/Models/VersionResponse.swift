//
//  VersionResponse.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 27/10/21.
//

import Foundation

struct VersionResponse: Codable {
    var success: Bool
    var version: VersionModel?
    var error: ErrorResponse?
}
