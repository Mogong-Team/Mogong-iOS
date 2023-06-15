//
//  LoginView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin

struct LoginView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("둘러보기")
                    .font(.body)
                    .foregroundColor(.gray)
                Spacer()
                    .frame(maxWidth: 50)
            }
            
            Text("Mogong")
                .font(.title)
            
            VStack {
                Text("지금 모공과 함께\n스터디를 시작하세요!")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                Text("책임감 있는 팀원들을 만나봐요!")
                    .font(.body)
                    .foregroundColor(.gray)
            }
            .padding()
            
            Text("3초만에 로그인하기")
                .font(.body)
                .fontWeight(.bold)
            
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
                    Text("kakao")
                }
                
                Button {
                    // 네이버 앱이 깔려져 있을때
                    if NaverThirdPartyLoginConnection
                        .getSharedInstance()
                        .isPossibleToOpenNaverApp()
                    {
                        NaverThirdPartyLoginConnection.getSharedInstance().delegate = viewModel.self
                        NaverThirdPartyLoginConnection
                            .getSharedInstance()
                            .requestThirdPartyLogin() // 로그인 요청
                        print(#function)
                    }
                    // 네이버 앱이 안깔려져 있을때 -> requestThirdPartyLogin을 통해 사파리로 이동
                    else {
                        NaverThirdPartyLoginConnection
                            .getSharedInstance()
                            .requestThirdPartyLogin()
                    }
                } label: {
                    Text("naver")
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "heart.fill")
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "heart.fill")
                }
            }
            .padding()
            
            Text("문의하기")
                .font(.body)
                .foregroundColor(.gray)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
