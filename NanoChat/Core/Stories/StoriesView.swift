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
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var isModalPresented = false
    @State private var updatedUser: User?
    @StateObject var viewModel: StoriesViewModel
    @State private var isStoriePresented = false
    @State var storieUser: String
    @State var storieId: String
    
    @State var nameImage: String

    @State private var isDiscoverModal = false
    
    

    
    init(current_user: User,storieUser: String = "", storieId: String = "") {
        self._viewModel = StateObject(wrappedValue: StoriesViewModel(current_user: current_user))
        self.current_user = current_user
        self._storieUser = State(initialValue: storieUser)
        self._storieId = State(initialValue: storieId)
        self._nameImage = State(initialValue: "asset_1")
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
                                            if user.username != current_user.username{
                                                Button{
                                                    isStoriePresented = true
                                                    
                                                    storieUser = user.username
                                                    storieId = user.id
                                                    
                                                    
                                                } label: {
                                                    VStack{
                                                        KFImage(URL(string: imageUrl))
                                                            .resizable()
                                                            .scaledToFill()
                                                            .frame(width: 100, height: 100)
                                                            .clipShape(Circle())
                                                        
                                                        Text(user.username).font(.system(size: 12)).bold().padding(.top,3).foregroundColor(colorScheme == .light ? .black : .white)
                                                    }
                                                }
                                            }
                                        }
                                        else {
                                            
                                            Button{
                                                isStoriePresented = true
                                                
                                                storieUser = user.username
                                                storieId = user.id
                                                
                                            } label: {
                                                VStack{
                                                    
                                                    ZStack {
                                                        Circle()
                                                            .foregroundColor(.gray)
                                                            .frame(width: 100)
                                                            .opacity(0.2)
                                                        Image(systemName: "person.fill")
                                                            .resizable()
                                                            .foregroundColor(colorScheme == .light ? .black : .white)
                                                            .frame(width: 45, height: 45)
                                                        
                                                    }
                                                    
                                                    Text(user.username).font(.system(size: 12)).bold().padding(.top,3)
                                                        .foregroundColor(colorScheme == .light ? .black : .white)
                                                }
                                            }
                                            
                                            
                                        }
                                    }
                                }
                            }
                        }.sheet(isPresented: $isStoriePresented) {
                            PostsView(storieUser: storieUser, storieId: storieId)
                            
                        }
                    }
                }.padding()
                HStack {
                    Text("Discover").bold()
                    Spacer()
                    
                }.padding()
                
                VStack {
                    HStack {

                            Image("asset_1")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 185, height: 300)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .accessibilityLabel("Discover")
                                .onTapGesture {
                                    isDiscoverModal = true
                                    nameImage = "asset_1"
                                }
                                
                        
                        
                        Image("asset_2").resizable().scaledToFill().frame(width: 185 , height: 300).clipShape(RoundedRectangle(cornerRadius: 10))
                            .accessibilityLabel("Discover")
                            .onTapGesture {
                                isDiscoverModal = true
                                nameImage = "asset_2"
                            }
                    }
                    
                    
                    HStack {
                        Image("asset_5").resizable().scaledToFill().frame(width: 185 , height: 300).clipShape(RoundedRectangle(cornerRadius: 10))
                            .accessibilityLabel("Discover")
                            .onTapGesture {
                                isDiscoverModal = true
                                nameImage = "asset_5"
                            }
                        
                        Image("asset_4").resizable().scaledToFill().frame(width: 185 , height: 300).clipShape(RoundedRectangle(cornerRadius: 10))
                            .accessibilityLabel("Discover")
                            .onTapGesture {
                                isDiscoverModal = true
                                nameImage = "asset_4"
                            }
                    }
                    HStack {
                        Image("asset_3").resizable().scaledToFill().frame(width: 185 , height: 300).clipShape(RoundedRectangle(cornerRadius: 10))
                            .accessibilityLabel("Discover")
                            .onTapGesture {
                                isDiscoverModal = true
                                nameImage = "asset_3"
                            }
                        
                        Image("asset_6").resizable().scaledToFill().frame(width: 185 , height: 300).clipShape(RoundedRectangle(cornerRadius: 10))
                            .accessibilityLabel("Discover")
                            .onTapGesture {
                                isDiscoverModal = true
                                nameImage = "asset_6"
                            }
                    }
                    HStack {
                        Image("asset_7").resizable().scaledToFill().frame(width: 185 , height: 300).clipShape(RoundedRectangle(cornerRadius: 10))
                            .accessibilityLabel("Discover")
                            .onTapGesture {
                                isDiscoverModal = true
                                nameImage = "asset_7"
                            }
                        
                        Image("asset_8").resizable().scaledToFill().frame(width: 185 , height: 300).clipShape(RoundedRectangle(cornerRadius: 10))
                            .accessibilityLabel("Discover")
                            .onTapGesture {
                                isDiscoverModal = true
                                nameImage = "asset_8"
                            }
                    }
                }.sheet(isPresented: $isDiscoverModal){
                    DiscoverModal(nameImage: nameImage)
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
                                    Button{
                                        isStoriePresented = true
                                        
                                        storieUser = current_user.username
                                        storieId = current_user.id
                                        
                                    } label: {
                                        KFImage(URL(string: imageUrl))
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 30, height: 30)
                                            .clipShape(Circle())
                                    }
                                  
                                    
                                } else {
                                    
                                    if let imageUrl = current_user.profileImageUrl {
                                        Button{
                                            isStoriePresented = true
                                            
                                            storieUser = current_user.username
                                            storieId = current_user.id
                                            
                                        } label: {
                                            KFImage(URL(string: imageUrl))
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 30, height: 30)
                                                .clipShape(Circle())
                                        }
                                        
                                    } else {
                                        
                                        Button{
                                            isStoriePresented = true
                                            
                                            storieUser = current_user.username
                                            storieId = current_user.id
                                            
                                        } label: {
                                            
                                            ZStack {
                                                Circle()
                                                    .foregroundColor(.gray)
                                                    .frame(width: 30)
                                                    .opacity(0.2)
                                                Image(systemName: "person.fill")
                                                    .resizable()
                                                    .foregroundColor(colorScheme == .light ? .black : .white)
                                                    .frame(width: 10, height: 10)
                                                
                                            }
                                        }
                                    }
                                }
                            }.accessibilityLabel("My Storie")
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
                                    .foregroundColor(colorScheme == .light ? .black : .white)
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
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                                    .frame(width: 15, height: 15)
                            }.accessibilityLabel("Profile")
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
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                                
                                
                            }.accessibilityLabel("Logout")
                        }
                    }
                }
                
                
                
                
            }.sheet(isPresented: $isModalPresented) {
                UserAccountView(user:current_user)
            }
        }.onAppear {
            fetchData()
        }
    }
    private func fetchData() {
        Task {
            do {
                try await viewModel.fetchImages()
                try await viewModel.fetchProfileImages()
                updatedUser = viewModel.current_user
                print("DEBUG \(String(describing: updatedUser?.username))")
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
}

#Preview {
    StoriesView(current_user: User.MOCK_USERS[0])
}
