//
//  SocialLogin.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/15.
//

import SwiftUI

struct SocialLogin: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        HStack(spacing: 50) {
            
            // MARK: - 카카오 로그인
            
            Button {
                viewModel.signInWithKakaoTalk()
            } label: {
                VStack {
                    Image("kakaoLogo")
                        .frame(width: 73, height: 73)
                    Text("카카오로\n시작하기")
                        .font(.pretendard(weight: .medium, size: 14))
                        .foregroundColor(Color(hexColor: "494949"))
                }
            }
            
            // MARK: - 구글 로그인
            
            Button {
                viewModel.signInWithGoogle()
            } label: {
                VStack {
                    Image("googleLogo")
                        .frame(width: 73, height: 73)
                    Text("구글로\n시작하기")
                        .font(.pretendard(weight: .medium, size: 14))
                        .foregroundColor(Color(hexColor: "494949"))
                }
            }
            
            // MARK: - 애플 로그인
            
            Button {
                viewModel.loginWithApple()
            } label: {
                VStack {
                    Image("appleLogo")
                        .frame(width: 73, height: 73)
                    Text("애플로\n시작하기")
                        .font(.pretendard(weight: .medium, size: 14))
                        .foregroundColor(Color(hexColor: "494949"))
                }
            }
            
            // MARK: - 네이버 로그인
            
//            Button {
//                viewModel.loginWithNaver()
//            } label: {
//                Image("appleLogo")
//                    .frame(width: 73, height: 73)
//            }
        }
    }
}

struct SocialLogin_Previews: PreviewProvider {
    static var previews: some View {
        SocialLogin()
    }
}
