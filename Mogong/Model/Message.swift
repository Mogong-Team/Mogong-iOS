//
//  Message.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/28.
//

import Foundation

struct Message: Identifiable, Hashable {
    let id: String
    var sender: User
    let message: String
    let timestamp: Date
    
    init(sender: User, message: String, timestamp: Date = Date()) {
        self.id = UUID().uuidString
        self.sender = sender
        self.message = message
        self.timestamp = timestamp
    }
}
