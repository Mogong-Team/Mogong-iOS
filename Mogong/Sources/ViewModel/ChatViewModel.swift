//
//  ChatViewModel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/28.
//

import SwiftUI
import Combine

class ChatViewModel: ObservableObject {

    var user1 = User.user1
    var user2 = User.user2
    
    lazy var chats = [
    Chat(participant1: user1, participant2: user2),
    Chat(participant1: user1, participant2: user2)
    ]
    
    var chat1Messages = [
        Message(sender: User.user1, message: "안녕하세요"),
        Message(sender: User.user2, message: "반갑습니다"),
        Message(sender: User.user2, message: "반갑습니다"),
        Message(sender: User.user1, message: "안녕하세요"),
        Message(sender: User.user1, message: "안녕하세요"),
        Message(sender: User.user1, message: "안녕하세요"),
        Message(sender: User.user1, message: "안녕하세요"),
        Message(sender: User.user1, message: "안녕하세요"),
        Message(sender: User.user1, message: "안녕하세요"),
        Message(sender: User.user1, message: "안녕하세요"),
        Message(sender: User.user1, message: "안녕하세요"),
        Message(sender: User.user1, message: "안녕하세요"),
        Message(sender: User.user1, message: "안녕하세요"),
        Message(sender: User.user1, message: "안녕하세요"),
    ]
    
    var chat2Messages = [
        Message(sender: User.user1, message: "안녕하세요"),
        Message(sender: User.user2, message: "반갑습니다"),
    ]
    
    init() {
        chats[0].messages = chat1Messages
        chats[1].messages = chat2Messages
    }
}
