//
//  Application.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/26.
//

import Foundation

struct Application: Identifiable, Hashable {
    let id: String
    let user: User
    let title: String
    let field: Field
    let introduction: String
    let experience: String
    
    init(user: User, title: String, field: Field, introduction: String, experience: String) {
        self.id = UUID().uuidString
        self.user = user
        self.title = title
        self.field = field
        self.introduction = introduction
        self.experience = experience
    }
}
