//
//  Chat.swift
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

extension Message {
    static var message1 = Message(sender: User.user1, message: "안녕하세요")
    static var message2 = Message(sender: User.user2, message: "반갑습니다")
}


struct Chat: Identifiable, Hashable {
    let id: String
    let participant1: User
    let participant2: User
    var messages: [Message]
    
    init(participant1: User, participant2: User, message: [Message] = []) {
        self.id = UUID().uuidString
        self.participant1 = participant1
        self.participant2 = participant2
        self.messages = message
    }
}

extension Chat {
    static var chat1 = Chat(
        participant1: User.user1,
        participant2: User.user1,
        message: [
            Message.message1,
            Message.message2
        ])
}
