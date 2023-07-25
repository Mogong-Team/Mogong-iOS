//
//  Application.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/26.
//

import Foundation

enum ApplicationStatus: String, CaseIterable, Codable {
    case pending = "대기중"
    case approved = "승인됨"
    case rejected = "거부됨"
}

struct Application: Identifiable, Codable {
    let id: String
    let user: User
    let title: String
    let position: Position2
    let introduction: String
    let experience: String
    var status: ApplicationStatus
    
    init(user: User, title: String, position: Position2, introduction: String, experience: String) {
        self.id = UUID().uuidString
        self.user = user
        self.title = title
        self.position = position
        self.introduction = introduction
        self.experience = experience
        self.status = .pending
    }
}
