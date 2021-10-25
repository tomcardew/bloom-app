//
//  FeaturedModel.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 20/10/21.
//

import Foundation

struct Instructor: Codable {
    let id: Int
    let name: String
    let description: String
    let isVisible: Bool
}

struct Room: Codable {
    let id: Int
    let name: String
    let description: String
}

struct ScheduleModel: Codable {
    let id: Int
    let date: String
    let end: String
    let start: String
    let theme: String?
    let isPrivate: Bool
    let available: Int
    let occupied: Int
    let soldOut: Bool
    
    let Instructor: Instructor
    let Rooms: Room
    
}
