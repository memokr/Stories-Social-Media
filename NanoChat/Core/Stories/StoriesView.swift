//
//  StoriesView.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 14/11/23.
//

import SwiftUI
import Kingfisher
import Combine

struct StoriesView: View {
    
    @State private var isModalPresented = false
    @State private var updatedUser: User?
    @StateObject var viewModel: StoriesViewModel
    @State private var capturedImage: UIImage?
    @State private var isStoriePresented = false
    
    
    init(current_user: User) {
        self._viewModel = StateObject(wrappedValue: StoriesViewModel(current_user: current_user))
        self.current_user = current_user
        self._capturedImage = State(wrappedValue: capturedImage)
    }
    
    
    let current_user: User
    
    
    var body: some View {
        
        NavigationStack{
            ScrollView{
                
                VStack{
                    HStack{
                        Text("Friends").bold()
                        Spacer()
                    }.padding(.bottom, 10)
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(viewModel.users) { user in
                                if user.username != current_user.username{
                                    VStack {
                                        
                                        if let imageUrl = user.profileImageUrl {
                                            Button{
                                                isStoriePresented = true
                                                
                                            } label: {
                                                VStack{
                                                    KFImage(URL(string: imageUrl))
                                                        .resizable()
                                                        .scaledToFill()
                                                        .frame(width: 100, height: 100)
                                                        .clipShape(Circle())
                                                    
                                                    Text(user.username).font(.system(size: 12)).bold().padding(.top,3).foregroundColor(.black)
                                                }
                                            }
                                        }
                                        else {
                                            ZStack {
                                                Circle()
                                                    .foregroundColor(.gray)
                                                    .frame(width: 100)
                                                    .opacity(0.2)
                                                Image(systemName: "person.fill")
                                                    .resizable()
                                                    .foregroundColor(.black)
                                                    .frame(width: 45, height: 45)
                                                
                                            }
                                            
                                            Text(user.username).font(.system(size: 12)).bold().padding(.top,3)
                                            
                                            
                                        }
                                    }
                                }
                            }
                        }.sheet(isPresented: $isStoriePresented) {
                            PostsView(post: Post.MOCK_POSTS[0])
                        }
                    }
                }.padding()
                
                HStack {
                    Text("Discover").bold()
                    Spacer()
                    
                }.padding()
                
                VStack {
                    HStack {
                        if let capturedImage = capturedImage {
                            Image(uiImage: capturedImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 185, height: 300)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } else {
                            Image("asset_1")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 185, height: 300)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                        Image("asset_2").resizable().scaledToFill().frame(width: 185 , height: 300).clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    
                    HStack {
                        Image("asset_3").resizable().scaledToFill().frame(width: 185 , height: 300).clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Image("asset_4").resizable().scaledToFill().frame(width: 185 , height: 300).clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }.refreshable {
                Task {
                    do {
                        try await viewModel.fetchImages()
                        try await viewModel.fetchProfileImages()
                        updatedUser = viewModel.current_user
                        print("DEBUG \(String(describing: updatedUser?.username))")
                    } catch {
                        print("Error fetching images: \(error)")
                    }
                }
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack(spacing: 1) {
                        Button(action: {
                            // Add your action for the first toolbar button
                        }) {
                            ZStack {
                                
                                Circle()
                                    .foregroundColor(.gray)
                                    .frame(width: 40)
                                    .opacity(0.2)
                                
                                
                                if let imageUrl = updatedUser?.profileImageUrl {
                                    KFImage(URL(string: imageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 30, height: 30)
                                        .clipShape(Circle())
                                    
                                } else {
                                    
                                    
                                    if let imageUrl = current_user.profileImageUrl {
                                        KFImage(URL(string: imageUrl))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 30, height: 30)
                                            .clipShape(Circle())
                                        
                                    } else {
                                        
                                        ZStack {
                                            Circle()
                                                .foregroundColor(.gray)
                                                .frame(width: 30)
                                                .opacity(0.2)
                                            Image(systemName: "person.fill")
                                                .resizable()
                                                .foregroundColor(.black)
                                                .frame(width: 10, height: 10)
                                            
                                        }
                                    }
                                }
                            }
                        }
                        
                        Button(action: {
                            // Add your action for the second toolbar button
                        }) {
                            ZStack {
                                Circle()
                                    .foregroundColor(.gray)
                                    .frame(width: 40)
                                    .opacity(0.2)
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .foregroundColor(.black)
                                    .frame(width: 15, height: 15)
                                
                            }
                        }
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Storie")
                        .font(.headline).bold()
                        .accessibilityAddTraits(.isHeader)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 1) {
                        Button(action: {
                            isModalPresented = true
                        }) {
                            ZStack {
                                Circle()
                                    .foregroundColor(.gray)
                                    .frame(width: 40)
                                    .opacity(0.2)
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .foregroundColor(.black)
                                    .frame(width: 15, height: 15)
                            }
                        }
                        
                        Button(action: {
                            AuthService.shared.signout()
                        }) {
                            ZStack {
                                Circle()
                                    .foregroundColor(.gray)
                                    .frame(width: 40)
                                    .opacity(0.2)
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.black)
                                
                            }
                        }
                    }
                }
                
                
                
                
            }.sheet(isPresented: $isModalPresented) {
                UserAccountView(user:current_user)
            }
        }
    }
}

#Preview {
    StoriesView(current_user: User.MOCK_USERS[0])
}
