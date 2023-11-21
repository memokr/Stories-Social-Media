//
//  User.swift
//  NanoChat
//
//  Created by Guillermo Kramsky on 15/11/23.
//

import Foundation


struct User: Identifiable, Codable {
    let id: String
    var username: String
    var profileImageUrl: String?
    let email: String
}


extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "memokr", profileImageUrl: "profile_5", email: "memo.kramsky@gmail.com"),
        .init(id: NSUUID().uuidString, username: "micalela", profileImageUrl: "profile_6", email: "micaela.panzeotto@gmail.com"),
        .init(id: NSUUID().uuidString, username: "alessandro_b", profileImageUrl: "profile_7", email: "alessandro.applefan@gmail.com"),
        .init(id: NSUUID().uuidString, username: "diego_ballesteros", profileImageUrl: "profile_8", email: "diego.ballesteros@gmail.com"),
        .init(id: NSUUID().uuidString, username: "alberto_puglia", profileImageUrl: "profile_9", email: "alberto.puglia@gmail.com")
    ]
}
