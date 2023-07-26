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
        return ChatListCell(chat: Chat.chat1)
        .environmentObject(UserViewModel())
    }
}
