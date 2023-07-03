//
//  MemberView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/29.
//

import SwiftUI

struct MemberView: View {
    @EnvironmentObject var viewModel: ApplicationViewModel
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .scaledToFit()
                .clipShape(Circle())
                .foregroundColor(.gray)
            
            Text(viewModel.application.user.username)
                .font(Font.system(size: 20, weight: .bold))
                .foregroundColor(.black)
            
            Text(viewModel.application.field.rawValue)
                .font(Font.system(size: 14, weight: .regular))
                .foregroundColor(.gray)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("간단한 자기소개")
                        .font(.pretendard(weight: .bold, size: 20))
                    
                    Spacer()
                        .frame(height: 15)
                    
                    Text(viewModel.application.introduction)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Text("프로젝트 경험 여부")
                        .font(.pretendard(weight: .bold, size: 20))
                    
                    Text(viewModel.application.experience)
                }
                
                Spacer()
            }
            
            Spacer()
            
            VStack {
                SelectButton(title: "채팅하기", state: .selected) {
                    isPresented = true
                }
            }
        }
        .padding(.horizontal, 20)
        .navigationDestination(isPresented: $isPresented) {
            ChatView(chat: Chat(participant1: User(name: "김민수민수", email: "", username: "민수민수"), participant2: User(name: "박민수민수", email: "", username: "박수박수")))
        }
    }
}

struct MemberView_Previews: PreviewProvider {
    static var previews: some View {
        MemberView()
            .environmentObject(ApplicationViewModel())
    }
}
