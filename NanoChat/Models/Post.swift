//
//  Post.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 21/11/23.
//

import Foundation


struct Post: Identifiable, Codable{
    let id: String
    let ownerUid: String
    let imageUrl: String
    var user: User?
}

extension Post{
    static var MOCK_POSTS: [Post] = [
        .init(
            id: NSUUID().uuidString,
            ownerUid: NSUUID().uuidString,
            imageUrl: "asset_1"
        )
    ]
}
