//
//  PostItemView.swift
//  Post
//
//  Created by isa nur fajar on 11/08/22.
//

import SwiftUI

struct PostItemView: View {
    var user : UserData?
    var item : PostModelData?
    @State var isNavigate : Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            NavigationLink(destination: PostViewDetail(user: user,item: item), isActive: $isNavigate, label: { EmptyView() })
            VStack(alignment: .leading, spacing: 2){
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
                            Image("placeholder")
                                .resizable()
                                .cornerRadius(8)
                                .frame(width: 64, height: 64)
                        @unknown default:
                            Text("Unknown error. Please try again.")
                                .foregroundColor(.red)
                        }
                    }
                    VStack(alignment: .leading, spacing: 6){
                        Text("\(user?.firstName ?? "") \(user?.lastName ?? "")")
                            .font(Font.custom("", size: 12))
                            .lineLimit(nil)
                        Text(item?.createdDate.toDate() ?? Date(), format: .dateTime)
                            .font(Font.custom("", size: 12))
                            .lineLimit(nil)
                    }
                    Spacer()
                }
                Text(item?.textContent ?? "")
                    .font(Font.custom("", size: 12))
                    .lineLimit(2)
            }.padding(6)
        }
        .onTapGesture {
            isNavigate.toggle()
        }
        .border(.gray, width: 2)
        .padding(6)
    }
}

struct PostItemView_Previews: PreviewProvider {
    static var previews: some View {
        PostItemView()
    }
}
