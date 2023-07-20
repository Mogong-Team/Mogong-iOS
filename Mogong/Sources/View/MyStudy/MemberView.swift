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
                .frame(width: 92, height: 92)
                .scaledToFit()
                .clipShape(Circle())
                .foregroundColor(.gray)
                .padding(.top, 50)
            
            Text(viewModel.application.user.username)
                .font(Font.custom("Pretendard", size: 28)
                    .weight(.bold))
                .foregroundColor(.black)
            
            ZStack {
                Rectangle()
                .foregroundColor(.clear)
                .frame(width: 141, height: 30)
                .background(Color(red: 0.46, green: 0.77, blue: 1))
                .cornerRadius(30)
                
                Text(viewModel.application.field.rawValue)
                    .font(Font.custom("Pretendard", size: 16))
                    .foregroundColor(.white)
            }
            
            
            HStack {
                VStack(alignment: .leading) {
                    Text("간단한 자기소개")
                        .font(
                            Font.custom("Pretendard", size: 18)
                            .weight(.bold)
                        )
                        .frame(width: 120, height: 25, alignment: .topLeading)
                    
                    Spacer()
                        .frame(height: 15)
                    
                    Text(viewModel.application.introduction)
                        .foregroundColor(Color(red: 0.57, green: 0.56, blue: 0.56))
                        .frame(width: 350, height: 180, alignment: .topLeading)
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Text("프로젝트 경험 여부")
                        .font(.pretendard(weight: .bold, size: 20))
                    
                    Text(viewModel.application.experience)
                        .foregroundColor(Color(red: 0.57, green: 0.56, blue: 0.56))
                        .frame(width: 350, height: 180, alignment: .topLeading)
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
