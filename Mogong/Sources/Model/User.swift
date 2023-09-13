//
//  User.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI

struct User: Identifiable, Hashable, Codable {
    var id: String
    var email: String
    var username: String = ""
    var userimageString: String = "TempBasicIUserimage"
    
    var submittedApplicationIds: [String] = []
    var joinedStudyIds: [String] = []
    var bookmarkedStudyIds: [String] = []
    
    init(id: String, email: String) {
        self.id = id
        self.email = email
    }
        
    init(id: String, email: String, username: String) {
        self.id = id
        self.email = email
        self.username = username
    }
    
    init(id: String, email: String, username: String, userimageString: String, submittedApplicationIds: [String], joinedStudyIds: [String], bookmarkedStudyIds: [String]) {
        self.id = id
        self.email = email
        self.username = username
        self.userimageString = userimageString
        self.submittedApplicationIds = submittedApplicationIds
        self.joinedStudyIds = joinedStudyIds
        self.bookmarkedStudyIds = bookmarkedStudyIds
    }
    
    static var user1: User {
        return User(id: "1", email: "1@gmail.com", username: "현석현석")
    }
    
    static var user2: User {
        return User(id: "2", email: "2@gmail.com", username: "예강예강")
    }
    
    static var user3: User {
        return User(id: "3", email: "3@gmail.com", username: "윤서윤서")
    }
    
    static var user4: User {
        return User(id: "4", email: "4@gmail.com", username: "민기민기")
    }
    
    static var user5: User {
        return User(id: "5", email: "5@gmail.com", username: "성윤성윤")
    }
    
    static var user6: User {
        return User(id: "6", email: "6@gmail.com", username: "종혁종혁")
    }
}
