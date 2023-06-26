//
//  User.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI

struct User: Identifiable{
    let id: String
    let name: String
    let email: String
    var username: String
    let joinedStudys: [Study]
    
    init(name: String, email: String, username: String) {
        self.id = UUID().uuidString
        self.name = name
        self.email = email
        self.username = username
        self.joinedStudys = []
    }
    
    init(id: String, name: String, email: String, username: String) {
        self.id = id
        self.name = name
        self.email = email
        self.username = username
        self.joinedStudys = []
    }
}
