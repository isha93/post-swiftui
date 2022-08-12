//
//  PostTests.swift
//  PostTests
//
//  Created by isa nur fajar on 11/08/22.
//

import XCTest
@testable import Post

class PostTests: XCTestCase {
    let expectedListPost = [PostModelData.with(id: "123", position: 1, ownerID: "123", createdDate: "123", textContent: "123", mediaContentPath: "123", tagIDS: [])]
    let expectedListUser = [UserData.with(id: "123", profileImagePath: "123", firstName: "Isa", lastName: "Fajar")]
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor
    func testSuccessFetchPost() async{
        
        let service = MockServicePost(mockDataUser: expectedListUser, mockDataPost: expectedListPost)
        
        let viewModel = PostViewModel(postServices: service)
        
        do {
            let user = try await service.getPost(endPoint: .getPost(page: 1))
            XCTAssertEqual(user.count, expectedListPost.count)
        }catch{
            XCTAssertNotNil(error)
        }

        XCTAssertTrue(!viewModel.loading)
        XCTAssertNotNil(viewModel.usersData)
    }
    
    @MainActor
    func testSuccessFetchUser() async{
        
        let service = MockServicePost(mockDataUser: expectedListUser, mockDataPost: expectedListPost)
        
        let viewModel = PostViewModel(postServices: service)
        do {
            let user = try await service.getUsers(endPoint: .getUser)
            XCTAssertEqual(user.count, expectedListUser.count)
        }catch{
            XCTAssertNotNil(error)
        }

        XCTAssertTrue(!viewModel.loading)
        XCTAssertNotNil(viewModel.postData)
    }
}
