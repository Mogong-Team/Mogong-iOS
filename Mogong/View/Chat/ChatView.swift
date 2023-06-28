//
//  ChatView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/28.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var typedMessage: String = ""
    
    @State private var messages = [
        Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
        Message(sender: User(id: "2", name: "최민수", email: "2@gmail.com", username: "최최민수"), message: "반갑습니다"),
        Message(sender: User(id: "2", name: "최민수", email: "2@gmail.com", username: "최최민수"), message: "반갑습니다"),
        Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
    ]
    
    @State private var currentUser: User = User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수")
    
    var body: some View {
        VStack {
            ForEach(messages, id: \.self) { message in
                HStack {
                    if message.sender == currentUser {
                        Spacer()
                        Text(message.message)
                            .padding()
                            .background(
                                ChatBubble(isCurrentUser: true)
                                    .fill(Color.blue)
                            )
                            .foregroundColor(.white)
                    } else {
                        Text(message.message)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        Spacer()
                    }
                }
            }
            
            Spacer()
            
            HStack {
                TextField("메시지를 입력하세요...", text: $typedMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    
                }, label: {
                    Text("보내기")
                })
                .padding()
            }
        }
    }
}

struct ChatBubble: Shape {
    var isCurrentUser: Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: [.topLeft, .topRight, isCurrentUser ? .bottomLeft : .bottomRight],
                                cornerRadii: CGSize(width: 15, height: 15))
        
        return Path(path.cgPath)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
