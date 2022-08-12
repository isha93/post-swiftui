//
//  PostModel.swift
//  Post
//
//  Created by isa nur fajar on 11/08/22.
//

import Foundation
struct PostModelData: Codable {
    let id: String
    let position: Int
    let ownerID, createdDate, textContent: String
    let mediaContentPath: String
    let tagIDS: [String]

    enum CodingKeys: String, CodingKey {
        case id, position
        case ownerID = "ownerId"
        case createdDate, textContent, mediaContentPath
        case tagIDS = "tagIds"
    }
}

typealias PostModel = [PostModelData]


extension PostModelData {
    static func with(
        id: String,
        position: Int,
        ownerID: String,
        createdDate: String,
        textContent: String,
        mediaContentPath: String,
        tagIDS:[String]) -> PostModelData {
        return PostModelData(id: id, position: position, ownerID: ownerID, createdDate: createdDate, textContent: textContent, mediaContentPath: mediaContentPath, tagIDS: tagIDS)
    }
}

