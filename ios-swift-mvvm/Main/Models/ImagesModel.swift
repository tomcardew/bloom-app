//
//  ImagesModel.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 25/10/21.
//

import Foundation

struct ImagesModel: Codable {
    
    let id: Int
    let url: String
    let status: Bool
    let section: String
    let name: String
    
}
