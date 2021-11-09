//
//  LoginResponse.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 04/11/21.
//

import Foundation

struct LoginResponse: Codable {
    var success: Bool
    var token: String?
    var user: User?
    var error: ErrorResponse?
}

struct User: Codable {
    var id: String
    var name: String
    var lastname: String?
    var email: String
    var pictureUrl: String?
    var isAdmin: Bool
    var isLeader: Bool
    var User_categories: [UserCategory]?
}

struct UserCategory: Codable {
    var id: Int
    var Categories: Category
}

struct Category: Codable {
    var id: Int
    var name: String
    var description: String
    var type: String
    var User_items: UserItems
}

struct UserItems: Codable {
    var id: Int
    var name: String
    var description: String?
    var pictureUrl: String?
}
