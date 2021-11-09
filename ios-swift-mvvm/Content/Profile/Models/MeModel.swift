//
//  MeModel.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 08/11/21.
//

import Foundation

struct MeModel: Codable {
    var profile: User?
    var minutesDone: Int
    var favorite: String
}
