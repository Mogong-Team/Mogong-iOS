//
//  User.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI

struct User: Identifiable, Hashable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var email: String
    var username: String
    
    var joinedStudyIds: [String] = []
    var bookmarkedStudyIds: [String] = []
    var submittedApplicationIds: [String] = []
        
    init(id: String, name: String, email: String, username: String) {
        self.id = id
        self.name = name
        self.email = email
        self.username = username
    }
    
    static var user1: User {
        return User(id: "1", name: "심현석", email: "1@gmail.com", username: "현석현석")
    }
    
    static var user2: User {
        return User(id: "2", name: "허예강", email: "2@gmail.com", username: "예강예강")
    }
    
    static var user3: User {
        return User(id: "3", name: "설윤서", email: "3@gmail.com", username: "윤서윤서")
    }
    
    static var user4: User {
        return User(id: "4", name: "신민기", email: "4@gmail.com", username: "민기민기")
    }
    
    static var user5: User {
        return User(id: "5", name: "김성윤", email: "5@gmail.com", username: "성윤성윤")
    }
    
    static var user6: User {
        return User(id: "6", name: "이종혁", email: "6@gmail.com", username: "종혁종혁")
    }
}
