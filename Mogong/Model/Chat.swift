//
//  Chat.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/28.
//

import Foundation

struct Chat: Identifiable {
    let id: String
    let sender: User
    let receiver: User
    let message: String
    let timestamp: Date

    init(sender: User, receiver: User, message: String, timestamp: Date = Date()) {
        self.id = UUID().uuidString
        self.sender = sender
        self.receiver = receiver
        self.message = message
        self.timestamp = timestamp
    }
}
