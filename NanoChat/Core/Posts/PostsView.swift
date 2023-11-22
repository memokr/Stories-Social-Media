//
//  PostsView.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 21/11/23.
//

import SwiftUI
import Kingfisher
import Firebase

struct PostsView: View {
    
    @Environment (\.dismiss) var dismiss
    
    var storieUser: String
    var storieId: String
    
    @State private var imageUrl: String?
    @Environment(\.colorScheme) var colorScheme

    
    var body: some View {
        NavigationView {
            ZStack {
                
                if let imageUrl = imageUrl {
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .scaledToFill()
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                                    .padding(.trailing,10)
                              
                                    
                            }
                            .padding()
                        }
                        Spacer()
                    }
                } else {
                    Text("\(storieUser) has no Stories")
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                dismiss()
                            }) {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                                    .padding(.trailing,10)
                              
                                    
                            }
                            .padding()
                        }
                        Spacer()
                    }
                }
                
            }.onAppear {
                Task {
                    do {
                        try await fetchImageUrl()
                    } catch {
                        print("Error fetching profile image URL: \(error)")
                    }
                }
            }
        }
    }
    
    func fetchImageUrl() async throws {
        let snapshot = try await Firestore.firestore()
            .collection("posts")
            .whereField("ownerUid", isEqualTo: storieId)
            .getDocuments()
        
        
        
        guard let post = snapshot.documents.first else {
            print("No posts found for the user.")
            return
        }
        
        // Access the data from the most recent post
        if let profileImageUrl = post.data()["imageUrl"] as? String {
            self.imageUrl = profileImageUrl
            print("DEBUG MODEL \(String(describing: profileImageUrl))")
        }
    }
}
 


