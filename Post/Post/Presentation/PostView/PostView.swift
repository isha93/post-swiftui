//
//  PostView.swift
//  Post
//
//  Created by isa nur fajar on 11/08/22.
//

import SwiftUI

struct PostView: View {
    @StateObject var postVM : PostViewModel = PostViewModel()
    @State var isNavigate : Bool = false
    @State private var searchText = ""
    
    var body: some View {
        GeometryReader{ geo in
            VStack{
                NavigationLink(destination: PostSearchView(postUserData: postVM.postUserData), isActive: $isNavigate, label: { EmptyView() })
                TextField("Search ...", text: $searchText)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .onTapGesture {
                        self.isNavigate = true
                    }
                ScrollView {
                    ForEach(postVM.postData, id: \.id) { item in
                        LazyVStack{
                            AnyView(
                                PostItemView(user: postVM.userItem,item: item)
                                    .onAppear {
                                        Task.init {
                                            try await postVM.loadMoreContent(currentItem: item)
                                        }
                                    }
                                    .accessibility(addTraits: .isButton)
                                    .accessibility(identifier: "PostItemView")
                            )
                        }
                        .onAppear {
                            postVM.postItem = item
                        }
                    }
                    postVM.isLoadMore
                    ?
                    AnyView(
                        ProgressView()
                            .progressViewStyle(.circular)
                            .frame(width: 64, height: 64)
                    )
                    :
                    AnyView(
                        EmptyView()
                    )
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Post Timeline")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                if postVM.isLoaded {
                    postVM.setupOfflineData()
                }else{
                    Task.init{
                        try await postVM.getPost()
                        postVM.getMatchUser()
                    }
                }
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(postVM: PostViewModel())
    }
}
