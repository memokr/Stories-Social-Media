//
//  ProfileImageView.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 19/11/23.
//

import SwiftUI
import Kingfisher
import Firebase

struct ProfileImageView: View {
    let user: User
    
    @State private var profileImageUrl: String?
    
    var body: some View {
        
        ZStack {
            if let imageUrl = profileImageUrl {
                
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
            
            } else {
                ZStack {
                    Circle()
                        .foregroundColor(.gray)
                        .frame(width: 120)
                        .opacity(0.2)
                    Image(systemName: "person.fill")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 55, height: 55)
                }
                
                
            }
        }.onAppear {
            Task {
                do {
                    try await fetchProfileImageUrl()
                } catch {
                    print("Error fetching profile image URL: \(error)")
                }
            }
        }
    }
    
    func fetchProfileImageUrl() async throws {
           let snapshot = try await Firestore.firestore().collection("users").document(user.id).getDocument()
           
           if let profileImageUrl = snapshot["profileImageUrl"] as? String {
               self.profileImageUrl = profileImageUrl
               print("DEBUG MODEL \(String(describing: profileImageUrl))")
           }
       }
}

#Preview {
    ProfileImageView(user: User.MOCK_USERS[0])
}
