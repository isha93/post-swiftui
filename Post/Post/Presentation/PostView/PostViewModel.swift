//
//  PostViewModel.swift
//  Post
//
//  Created by isa nur fajar on 11/08/22.
//

import Foundation

@MainActor
class PostViewModel : ObservableObject {
    @Published var postData : PostModel = []
    @Published var usersData : UserModel = []
    @Published var isLoadMore : Bool = false
    @Published var loading : Bool = false
    @Published var userItem : UserData?
    @Published var isLoaded : Bool = false
    @Published var postUserData : PostUserModel = []
    
    var postItem : PostModelData?
    private var postServices : PostServicesProtocol
    
    var totalPages = 0
    var page : Int = 0
    
    var prefs = UserDefaults.standard
    
    init(postServices: PostServicesProtocol = PostServices()) {
        self.postServices = postServices
    }
    
    func getPost() async throws {
        self.loading = true
        do{
            let data = try await postServices.getPost(endPoint: .getPost(page: page))
            self.postData.append(contentsOf: data)
            try self.prefs.setObject(self.postData, forKey: "POST")
            try await self.getUsers()
            self.loading = false
        } catch let error as NetworkError {
            print(error)
        }
    }
    
    func getUsers() async throws {
        self.loading = true
        do{
            let users = try await postServices.getUsers(endPoint: .getUser)
            self.usersData = users
            self.getMatchUser()
            try self.prefs.setObject(self.usersData, forKey: "USER")
            self.loading = false
        }catch let error as NetworkError {
            print(error)
        }
    }
    
    func loadMoreContent(currentItem item: PostModelData) async throws{
        let thresholdIndex = self.postData.last
        if thresholdIndex?.position == item.position {
            self.isLoadMore = true
            self.page += 1
            do{
                try await Task.sleep(nanoseconds: 1_000_000_000)
                try await self.getPost()
            }catch {
            
            }
        }
    }
    
    func getMatchUser(){
        guard let postItem = postItem else {
            return
        }
        for user in usersData where user.id == postItem.ownerID {
            self.userItem = user
            self.postUserData.append(PostUserData(post: postItem, user: user))
            print(postUserData)
        }
    }
    
    func getMatchTags(){
        guard let postItem = postItem else {
            return
        }
        for (index, element)  in postItem.tagIDS.enumerated() where postItem.tagIDS[index] == usersData[index].id {
            print(element)
        }
    }
    
    func setupOfflineData(){
        do{
            self.usersData = try prefs.getObject(forKey: "USER", castTo: UserModel.self)
            self.postData = try prefs.getObject(forKey: "POST", castTo: PostModel.self)
            self.getMatchUser()
        }catch{
            print(error)
        }
    }
}
