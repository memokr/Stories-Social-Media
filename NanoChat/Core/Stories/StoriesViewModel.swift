//
//  StoriesViewModel.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 17/11/23.
//

import Foundation
import Firebase

class StoriesViewModel: ObservableObject {
    @Published var users = [User]()
    
    
    @Published var current_user: User
    
    init(current_user: User) {
        self.current_user = current_user
        Task {try await fetchAllUsers()}
    }
    
    
    
    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await UserServices.fetchAllUsers()
    }
    
    
    @MainActor
    func fetchImages() async throws {
        
        do {
            
            let snapshot = try await Firestore.firestore().collection("users").getDocuments()
            
            self.users = snapshot.documents.compactMap({try? $0.data(as: User.self)})
            
        } catch {
            print("Current user not found in the fetched users.")
            
        }
    }
    
    func fetchProfileImages() async throws {
        
        do {
            
            let snapshot = try await Firestore.firestore().collection("users").document(current_user.id).getDocument()
            
            
            if let profileImageUrl = snapshot["profileImageUrl"] as? String {
                self.current_user.profileImageUrl = profileImageUrl
                print("DEBUG MODEL \(String(describing: current_user.profileImageUrl))" )
            }
        } catch {
            print("Current user not found in the fetched users.")
            
        }
    }
    
    
    
}
