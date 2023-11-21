//
//  PostService.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 21/11/23.
//

import Firebase

struct PostService {
    
    private static let postsCollection = Firestore.firestore().collection("posts")
    
    
    func fetchPosts(){
        
    }
    
    static func fetchUserPosts(uid:String) async throws -> [Post]{
        let snapshot = try await postsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapshot.documents.compactMap({try $0.data(as: Post.self)})
    }
    
}
