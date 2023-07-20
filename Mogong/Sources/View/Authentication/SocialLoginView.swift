//
//  SocialLoginView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/15.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices

struct SocialLoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        HStack {
            Button {
                if (UserApi.isKakaoTalkLoginAvailable()) {
                    UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            print("loginWithKakaoTalk() success.")
                            
                            //do something
                            _ = oauthToken
                        }
                    }
                } else {
                    UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            print("loginWithKakaoAccount() success.")
                            
                            //do something
                            _ = oauthToken
                        }
                    }
                }
            } label: {
                Image("kakaoLogo")
                    .frame(width: 73, height: 73)
//                ZStack {
//                    Circle()
//                        .frame(width: 73, height: 73)
//                        .foregroundColor(.yellow)
//
//                    Image(systemName: "message.fill")
//                        .resizable()
//                        .frame(width: 25, height: 22)
//                        .foregroundColor(.black)
//                }
            }
          
//            Button {
//                // 네이버 앱이 깔려져 있을때
//                if NaverThirdPartyLoginConnection
//                    .getSharedInstance()
//                    .isPossibleToOpenNaverApp()
//                {
//                    NaverThirdPartyLoginConnection.getSharedInstance().delegate = viewModel.self
//                    NaverThirdPartyLoginConnection
//                        .getSharedInstance()
//                        .requestThirdPartyLogin() // 로그인 요청
//                    print(#function)
//                }
//                // 네이버 앱이 안깔려져 있을때 -> 웹에서 로그인 요청
//                else {
//                    NaverThirdPartyLoginConnection
//                        .getSharedInstance()
//                        .requestThirdPartyLogin()
//                }
//            } label: {
//                Text("N")
//                    .frame(width: 50, height: 50)
//                    .background(.green)
//                    .foregroundColor(.white)
//                    .clipShape(Circle())
//            }
            
            Button {
                handleGoogleSignIn()
            } label: {
                Image(systemName: "g.circle.fill")
                    .resizable()
                    .frame(width: 73, height: 73)
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }

            Button {
                viewModel.signInWithApple()
            } label: {
                Image("appleLogo")
                    .frame(width: 73, height: 73)
//                ZStack {
//                    Circle()
//                        .frame(width: 73, height: 73)
//                        .foregroundColor(.black)
//
//                    Image(systemName: "applelogo")
//                        .resizable()
//                        .frame(width: 20, height: 23)
//                        .foregroundColor(.white)
//                }
//                Image(systemName: "applelogo")
//                    .resizable()
//                    .frame(width: 100, height: 100)
//                    .background(.black)
//                    .foregroundColor(.white)
//                    .clipShape(Circle())
            }
        }
    }
    
    func handleGoogleSignIn() {
        guard let rootVC = UIApplication.shared.windows.first?.rootViewController else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootVC) { signInResult, error in
            if let error = error {
                print(error)
            } else {
                
            }
        }
    }
}

struct SocialLoginView_Previews: PreviewProvider {
    static var previews: some View {
        SocialLoginView()
    }
}
