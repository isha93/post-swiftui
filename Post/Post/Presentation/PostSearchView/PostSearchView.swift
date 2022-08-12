//
//  PostSearchView.swift
//  Post
//
//  Created by isa nur fajar on 12/08/22.
//

import SwiftUI

struct PostSearchView: View {
    var postUserData : PostUserModel?
    @State private var searchText = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader{ geo in
            VStack{
                TextField("Search ...", text: $searchText)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                ScrollView {
                    LazyVStack{
                        ForEach(postUserData?.filter({searchText.isEmpty ? true : $0.user.firstName.contains(searchText)}) ?? []) { item in
                            LazyVStack{
                                AnyView(
                                    PostItemView(user: item.user,item: item.post)
                                        .accessibility(addTraits: .isButton)
                                        .accessibility(identifier: "PostItemView")
                                )
                            }
                        }
                        ForEach(postUserData?.filter({searchText.isEmpty ? true : $0.user.lastName.contains(searchText)}) ?? []) { item in
                            LazyVStack{
                                AnyView(
                                    PostItemView(user: item.user,item: item.post)
                                        .accessibility(addTraits: .isButton)
                                        .accessibility(identifier: "PostItemView")
                                )
                            }
                        }
                        ForEach(postUserData?.filter({searchText.isEmpty ? true : $0.post.textContent.contains(searchText)}) ?? []) { item in
                            LazyVStack{
                                AnyView(
                                    PostItemView(user: item.user,item: item.post)
                                        .accessibility(addTraits: .isButton)
                                        .accessibility(identifier: "PostItemView")
                                )
                            }
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Search Post")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.black)
                }
            })
        }
    }
}

struct PostSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PostSearchView()
    }
}
