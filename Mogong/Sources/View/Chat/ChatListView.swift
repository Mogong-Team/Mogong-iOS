//
//  ChatListView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/28.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var viewModel: ChatViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    var a = ["1", "2", "3", "4"]
    
    var body: some View {
        VStack {
            //messagesView
            
            Text("채팅이 없습니다.")
                .font(.pretendard(weight: .semiBold, size: 18))
        }
        .navigationTitle("메세지")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var messagesView: some View {
        List {
            ForEach(viewModel.chats, id: \.self) { chat in
                HStack(spacing: 16) {
                    Image(systemName: "person.fill")
                        .font(.system(size: 32))
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 44)
                                .stroke(Color(.label), lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(viewModel.user1.username)
                            .font(.system(size: 16, weight: .bold))
                        Text("Hiiii")
                            .font(.system(size: 14))
                            .foregroundColor(Color(.lightGray))
                    }
                    Spacer()
                    
                    Text("10:30")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(.lightGray))
                }
                .padding(.vertical, 8)
                .swipeActions {
                    Button(action: {
                        //TODO: 채팅방 나가기
                    }, label: {
                        Text("나가기")
                    })
                    .tint(.red)
                }
            }
        }
        .listStyle(.plain)
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ChatListView()
                .environmentObject(ChatViewModel())
                .environmentObject(UserViewModel())
        }
    }
}

