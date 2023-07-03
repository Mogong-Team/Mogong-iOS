//
//  SettingView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/03.
//

import SwiftUI

struct SettingView: View {
    
    @State private var username = "민수민수"
    @State private var changeUsername: Bool = false
    @FocusState var focuseUsername: Bool
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("닉네임")
                        .font(.pretendard(weight: .bold, size: 18))
                    Spacer()
                    
                    if changeUsername {
                        TextField("", text: $username)
                            .multilineTextAlignment(.trailing)
                            .font(.pretendard(weight: .regular, size: 18))
                            .focused($focuseUsername)
                        
                        Button {
                            withAnimation(.none) {
                                changeUsername = false
                            }
                        } label: {
                            Image(systemName: "checkmark")
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                        }
                    } else {
                        Text(username)
                            .font(.pretendard(weight: .regular, size: 18))
                        
                        Button {
                            withAnimation(.none) {
                                changeUsername = true
                                focuseUsername = true
                            }
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                        }
                    }
                }
                .frame(height: 20)
            }
            
            Spacer()
                .frame(height: 50)
            
            VStack(spacing: 20) {
                NavigationLink {
                    //
                } label: {
                    HStack {
                        Text("이용약관")
                            .font(.pretendard(weight: .bold, size: 18))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    }
                }
                
                NavigationLink {
                    //
                } label: {
                    HStack {
                        Text("개인정보 처리방침")
                            .font(.pretendard(weight: .bold, size: 18))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                    }
                }
                
                HStack {
                    Text("앱 버전")
                        .font(.pretendard(weight: .bold, size: 18))
                    Spacer()
                    Text("1.0")
                        .font(.pretendard(weight: .regular, size: 18))
                }
            }
            
            Spacer()
            
            VStack {
                Button {
                    
                } label: {
                    Text("탈퇴하기")
                        .font(.pretendard(weight: .regular, size: 15))
                        .foregroundColor(.red)
                }
            }
            .padding(.vertical, 25)
        }
        .padding(.horizontal, 20)
        .navigationTitle("설정")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

