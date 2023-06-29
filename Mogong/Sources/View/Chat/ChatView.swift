//
//  ChatView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/28.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var viewModel: UserViewModel
        
    var chat: Chat
    
    @State private var currentUser: User = User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수")
    
    @State private var message: String = ""
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(chat.messages, id: \.self) { message in
                        HStack {
                            if message.sender.id == currentUser.id {
                                Spacer()
                                HStack {
                                    Text(message.timestamp.toMessageString())
                                        .font(Font.system(size: 12, weight: .regular))
                                        .foregroundColor(.gray)

                                    Text(message.message)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                }
                            } else {
                                HStack {
                                    Text(message.message)
                                        .padding()
                                        .background(Color.gray)
                                    .foregroundColor(.white)
                                    
                                    Text(message.timestamp.toMessageString())
                                        .font(Font.system(size: 12, weight: .regular))
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }

            //Spacer()

            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.gray)
                    .frame(height: 47)
                
                HStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 27, height: 27)
                        .scaledToFit()
                        .clipShape(Circle())
                    
                    TextField("메시지를 입력하세요...", text: $message)
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "paperplane.fill")
                    })
                }
                .padding()
            }
        }
        .padding(.horizontal, 20)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(chat: Chat(
            participant1:
                User(id: "2", name: "최민수", email: "2@gmail.com", username: "최최민수"),
            participant2:
                User(id: "2", name: "최민수", email: "2@gmail.com", username: "최최민수"),
            message: [
                Message(sender: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"), message: "안녕하세요"),
                Message(sender: User(id: "2", name: "최민수", email: "2@gmail.com", username: "최최민수"), message: "반갑습니다"),
            ]
        ))
    }
}
