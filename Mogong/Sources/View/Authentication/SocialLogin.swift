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
                Image("kakaoLogo")
                    .frame(width: 73, height: 73)
                
            }
            
            // MARK: - 구글 로그인
            
            Button {
                viewModel.signInWithGoogle()
            } label: {
                Image("googleLogo")
                    .frame(width: 73, height: 73)
            }
            
            // MARK: - 애플 로그인
            
            Button {
                viewModel.loginWithApple()
            } label: {
                Image("appleLogo")
                    .frame(width: 73, height: 73)
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
