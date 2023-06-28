//
//  ChatViewModel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/28.
//

import SwiftUI
import Combine

class ChatViewModel: ObservableObject {

    var user1 = User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수")
    var user2 = User(id: "2", name: "최민수", email: "2@gmail.com", username: "최최민수")
    
    lazy var chats = [
    Chat(participant1: user1, participant2: user2),
    Chat(participant1: user1, participant2: user2)
    ]
    
    var chat1Messages = [
        Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
        Message(sender: User(id: "2", name: "최민수", email: "2@gmail.com", username: "최최민수"), message: "반갑습니다"),
        Message(sender: User(id: "2", name: "최민수", email: "2@gmail.com", username: "최최민수"), message: "반갑습니다"),
        Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
        Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
        Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
        Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
        Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
        Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
        Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
        Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
        Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
        Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
        Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
    ]
    
    var chat2Messages = [
        Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
        Message(sender: User(id: "2", name: "최민수", email: "2@gmail.com", username: "최최민수"), message: "반갑습니다"),
    ]
    
    init() {
        chats[0].messages = chat1Messages
        chats[1].messages = chat2Messages
    }
}
