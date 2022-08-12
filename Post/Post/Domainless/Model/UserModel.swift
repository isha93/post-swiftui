//
//  UserModel.swift
//  Post
//
//  Created by isa nur fajar on 11/08/22.
//

import Foundation

// MARK: - User
struct UserData: Codable {
    let id: String
    let profileImagePath: String
    let firstName, lastName: String
}

typealias UserModel = [UserData]

extension UserData {
    static func with(
        id: String,
        profileImagePath: String,
        firstName: String,
        lastName: String) -> UserData {
        return UserData(id: id, profileImagePath: profileImagePath, firstName: firstName, lastName: lastName)
    }
}
