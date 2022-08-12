//
//  PostUserModel.swift
//  Post
//
//  Created by isa nur fajar on 12/08/22.
//

import Foundation
struct PostUserData: Identifiable {
    var id = UUID()
    let post : PostModelData
    let user : UserData
}

typealias PostUserModel = [PostUserData]
