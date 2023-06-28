//
//  Chat.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/28.
//

import Foundation

class Chat: Identifiable {
    let id: String
    let participant1: User
    let participant2: User
    var messages: [Message]
    
    init(participant1: User, participant2: User) {
        self.id = UUID().uuidString
        self.participant1 = participant1
        self.participant2 = participant2
        self.messages = []
    }
    
    func addMessage(message: Message) {
        messages.append(message)
    }
}
