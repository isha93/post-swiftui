//
//  PostViewDetail.swift
//  Post
//
//  Created by isa nur fajar on 11/08/22.
//

import SwiftUI

struct PostViewDetail: View {
    @StateObject var detailVM: PostDetailViewModel = PostDetailViewModel()
    
    var user : UserData?
    var item : PostModelData?
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        GeometryReader{ geo in
            VStack(alignment: .leading, spacing: 10){
                HStack(alignment: .center, spacing: 10){
                    AsyncImage(url: URL(string: user?.profileImagePath ?? ""), transaction: .init(animation: .spring(response: 1.6))) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .progressViewStyle(.circular)
                                .frame(width: 64, height: 64)
                            
                        case .success(let image):
                            image
                                .resizable()
                                .cornerRadius(8)
                                .frame(width: 64, height: 64)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .cornerRadius(8)
                                .frame(width: 64, height: 64)
                        @unknown default:
                            Text("Unknown error. Please try again.")
                                .foregroundColor(.red)
                        }
                    }
                    VStack(alignment: .leading, spacing: 6){
                        Text(user?.firstName ?? "")
                            .font(Font.custom("", size: 14))
                            .lineLimit(nil)
                        Text(item?.createdDate.toDate() ?? Date(), format: .dateTime)
                            .font(Font.custom("", size: 14))
                            .lineLimit(nil)
                    }
                    Spacer()
                }
                Text(item?.textContent ?? "")
                    .font(Font.custom("", size: 14))
                    .lineLimit(nil)
                AsyncImage(url: URL(string: item?.mediaContentPath ?? ""), transaction: .init(animation: .spring(response: 1.6))) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .progressViewStyle(.circular)
                            .frame(width: nil, height: 400)
                        
                    case .success(let image):
                        image
                            .resizable()
                            .cornerRadius(8)
                            .frame(width: nil, height: 400)
                    case .failure:
                        Image("placeholder")
                            .resizable()
                            .cornerRadius(8)
                            .frame(width: nil, height: 400)
                    @unknown default:
                        Text("Unknown error. Please try again.")
                            .foregroundColor(.red)
                    }
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack{
                        ForEach(detailVM.tagsUser, id:\.self) { item in
                            Text(item)
                        }
                    }
                    Divider()
                }
                .frame(width: nil, height: 40, alignment: .center)
                
                
            }.padding(6)
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("Post Detail")
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
        .onAppear {
            Task.init {
                detailVM.postItem = item
                detailVM.userItem = user
                detailVM.getMatchTags()
            }
        }
    }
}

struct PostViewDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostViewDetail()
    }
}
