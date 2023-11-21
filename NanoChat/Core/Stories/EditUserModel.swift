//
//  EditUserModel.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 17/11/23.
//

import Foundation
import PhotosUI
import Firebase
import SwiftUI


@MainActor
class EditUserModel: ObservableObject{
    
    @Published var user: User
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage (fromItem: selectedImage)}}
    }
    
    @Published var profileImage: Image?
    
    private var uiImage: UIImage?
    
    init(user: User){
        self.user = user
    }
    

 
    
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
        
    }
    
    func updateUserData() async throws {
        
        var data = [String: Any]()
        
        if let uiImage = uiImage{
           let imageUrl = try? await ImageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
        }
        
        if !data.isEmpty{
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
        
        
    }
    
    func loadRecentImage() async {
    }
}
