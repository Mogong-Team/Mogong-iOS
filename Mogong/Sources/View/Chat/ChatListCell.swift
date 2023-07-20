//
//  ChatListCell.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/28.
//

import SwiftUI

struct ChatListCell: View {
    @EnvironmentObject var viewModel: UserViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    var chat: Chat
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .scaledToFit()
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(viewModel.currentUser.id == chat.participant1.id ? chat.participant1.username : chat.participant2.username)
                        .font(Font.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text(chat.messages.last?.message ?? "")
                        .font(Font.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Text(chat.messages.last?.timestamp.toChatString() ?? "")
                    .font(Font.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
            }

        }
    }
}

struct ChatListCell_Previews: PreviewProvider {
    static var previews: some View {
        return ChatListCell(chat: Chat(
                    participant1: User(id: "2", name: "최민수", email: "2@gmail.com", username: "최최민수"),
                    participant2: User(id: "2", name: "최민수", email: "2@gmail.com", username: "최최민수"),
                    message: [
                        Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
                        Message(sender: User(id: "2", name: "최민수", email: "2@gmail.com", username: "최최민수"), message: "반갑습니다"),
                    ]
                ))
                .environmentObject(UserViewModel())
//
//        ChatListCell(chat: Chat(
//            participant1:
//                User(id: "2", name: "최민수", email: "2@gmail.com", username: "최최민수"),
//            participant2:
//                User(id: "2", name: "최민수", email: "2@gmail.com", username: "최최민수"),
//            message: [
//                Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
//                Message(sender: User(id: "2", name: "최민수", email: "2@gmail.com", username: "최최민수"), message: "반갑습니다"),
//            ]
//        ))
    }
}
