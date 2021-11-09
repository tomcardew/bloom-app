//
//  MeResponse.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 08/11/21.
//

import Foundation

struct MeResponse: Codable {
    var success: Bool
    var data: MeModel?
    var error: ErrorResponse?
}
