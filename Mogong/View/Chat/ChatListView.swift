//
//  ChatListView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/28.
//

import SwiftUI

struct ChatListView: View {
    @EnvironmentObject var viewModel: ChatViewModel
    
    var a = ["1", "2", "3", "4"]
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.chats) { chat in
                        NavigationLink {
                            ChatView(chat: chat)
                        } label: {
                            ChatListCell(chat: chat)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .navigationTitle("채팅")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
            .environmentObject(ChatViewModel())
    }
}

