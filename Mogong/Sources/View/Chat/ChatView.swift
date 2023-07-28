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
    
    @State private var currentUser: User = User.user1
    
    @State private var message: String = ""
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(chat.messages, id: \.self) { message in
                        HStack {
                            if message.sender.id == currentUser.id {
                                Spacer()
                                VStack {
                                    Text(message.message)
                                        .padding()
                                        .background(Color(red: 0, green: 0.78, blue: 0.96))
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                    Text(message.timestamp.toMessageString())
                                        .font(Font.system(size: 12, weight: .regular))
                                        .foregroundColor(.gray)
                                }
                            } else {
                                VStack {
                                    Text(message.message)
                                        .padding()
                                        .background(Color(red: 0.77, green: 0.77, blue: 0.77))
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                                    
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
        ChatView(chat: Chat.chat1)
    }
}
