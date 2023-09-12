//
//  SettingView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/26.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var viewModel: UserViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var username = "민수민수"
    @State private var changeUsername: Bool = false
    @FocusState var focuseUsername: Bool
    
    var body: some View {
            VStack(spacing: 20) {
                Spacer().frame(height: 15)
                
//                NavigationLink {
//                    EditUserInfo()
//                } label: {
//                    HStack {
//                        Text("닉네임")
//                            .font(.pretendard(weight: .bold, size: 18))
//                            .foregroundColor(.black)
//                        Spacer()
//                        Text("\(username)")
//                            .foregroundColor(.black)
//                        Image(systemName: "chevron.right")
//                            .foregroundColor(.black)
//                    }
//                }
//                Divider()
                
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
                    Spacer()
                    Text("로그아웃")
                        .foregroundColor(.red)
                        .onTapGesture {
                            // TODO: 로그아웃
                        }
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .navigationBarTitle("설정", displayMode: .large)
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

