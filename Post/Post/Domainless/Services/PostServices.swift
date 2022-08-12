//
//  PostServices.swift
//  Post
//
//  Created by isa nur fajar on 11/08/22.
//

import Foundation

protocol PostServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    func getPost(endPoint: NetworkFactory) async throws -> PostModel
    func getUsers(endPoint: NetworkFactory) async throws -> UserModel
}

final class PostServices: PostServicesProtocol {
    var networker: NetworkerProtocol
    
    init(networker: NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func getPost(endPoint: NetworkFactory) async throws -> PostModel {
        return try await networker.taskAsync(type: PostModel.self, endPoint: endPoint, isMultipart: false)
    }
    func getUsers(endPoint: NetworkFactory) async throws -> UserModel {
        return try await networker.taskAsync(type: UserModel.self, endPoint: endPoint, isMultipart: false)
    }
}

class MockServicePost : PostServicesProtocol {
    var networker: NetworkerProtocol
    
    let mockDataUser: UserModel?
    let mockDataPost: PostModel?
    
    init(mockDataUser: UserModel?, mockDataPost: PostModel, networker: NetworkerProtocol = Networker()) {
        self.mockDataUser = mockDataUser
        self.mockDataPost = mockDataPost
        self.networker = networker
    }
    
    func getPost(endPoint: NetworkFactory) async throws -> PostModel {
        return self.mockDataPost!
    }
    
    func getUsers(endPoint: NetworkFactory) async throws -> UserModel {
        return self.mockDataUser!
    }
    
}
