//
//  SettingView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/26.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var viewModel: UserViewModel
    
    @State private var username = "민수민수"
    @State private var changeUsername: Bool = false
    @FocusState var focuseUsername: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            NavigationLink {
                EditUserInfo()
            } label: {
                rightArrowLabel(title: "프로필 수정")
            }
            Divider()
            
            VStack(spacing: 20) {
                NavigationLink {
                    
                } label: {
                    rightArrowLabel(title: "서비스 이용약관")
                }
                Divider()
                
                NavigationLink {
                    
                } label: {
                    rightArrowLabel(title: "개인정보 처리방침")
                }
                Divider()
                
                HStack {
                    Text("앱 버전")
                        .font(.pretendard(weight: .bold, size: 18))
                    Spacer()
                    Text("1.0")
                        .font(.pretendard(weight: .regular, size: 18))
                }
                Divider()
            }
            
            HStack {
                Text("로그아웃")
                    .onTapGesture {
                        // TODO: Logout User
                    }
                Spacer()
                Text("탈퇴하기")
                    .foregroundColor(.red)
                    .onTapGesture {
                        // TODO: delete User
                    }
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .navigationTitle("설정")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct rightArrowLabel: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.pretendard(weight: .bold, size: 18))
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.black)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

