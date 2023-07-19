//
//  AuthView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Image("LoginMogongLogo")
                    .padding(20)
                
                Image("LoginMainImg")
                    .frame(width: 130, height: 200)
                
                VStack(spacing: 10) {
                    Text("지금 모공과 함께\n스터디를 시작하세요!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        
                    
                    Text("책임감 있는 팀원들을 만나봐요!")
                        .font(.body)
                        .foregroundColor(.gray)
                    
                }
                .padding(30)
                
                Text("3초만에 로그인하기")
                    .fontWeight(.bold)
                    .padding(.top, 10)
                
                SocialLoginView()
                    .padding()
                
                // 피그마에는 없어서 일단 주석처리
//                NavigationLink {
//
//                } label: {
//                    Text("문의하기")
//                        .font(.body)
//                        .foregroundColor(.gray)
//                }
            }
            .navigationBarHidden(true)
            .accentColor(.red)
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
