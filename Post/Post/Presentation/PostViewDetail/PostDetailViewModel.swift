//
//  PostDetailViewModel.swift
//  Post
//
//  Created by isa nur fajar on 11/08/22.
//

import Foundation

@MainActor
class PostDetailViewModel : ObservableObject {
    @Published var userItem : UserData?
    @Published var postItem : PostModelData?
    @Published var tagsUser : [String] = []
    
    private var postServices : PostServicesProtocol
    private var prefs = UserDefaults.standard

    
    init(postServices: PostServicesProtocol = PostServices()) {
        self.postServices = postServices
    }
    
    func getMatchTags(){
        guard let postItem = postItem else {
            return
        }
        do {
            let allUser : UserModel = try prefs.getObject(forKey: "USER", castTo: UserModel.self)
            for tags in postItem.tagIDS{
                for user in allUser where tags == user.id{
                    self.tagsUser.append(user.firstName)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
