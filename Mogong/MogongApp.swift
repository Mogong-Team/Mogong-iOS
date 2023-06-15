//
//  MogongApp.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import NaverThirdPartyLogin

@main
struct MogongApp: App {
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var studyViewModel = StudyViewModel()
    @StateObject var rankViewModel = RankViewModel()
    @StateObject var userViewModel = UserViewModel()
    
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: "ad63ed85978c701f2e947c5e85b1215e")
        
        // Naver SDK 초기화
        // 네이버 앱으로 로그인 허용
        NaverThirdPartyLoginConnection.getSharedInstance()?.isNaverAppOauthEnable = true
        // 브라우저 로그인 허용
        NaverThirdPartyLoginConnection.getSharedInstance()?.isInAppOauthEnable = true
        // NaverThirdPartyConstantsForApp.h에 선언한 상수 등록
        NaverThirdPartyLoginConnection.getSharedInstance().serviceUrlScheme = kServiceAppUrlScheme
        NaverThirdPartyLoginConnection.getSharedInstance().consumerKey = kConsumerKey
        NaverThirdPartyLoginConnection.getSharedInstance().consumerSecret = kConsumerSecret
        NaverThirdPartyLoginConnection.getSharedInstance().appName = kServiceAppName
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loginViewModel)
                .environmentObject(studyViewModel)
                .environmentObject(rankViewModel)
                .environmentObject(userViewModel)
                .onOpenURL(perform: { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        AuthController.handleOpenUrl(url: url)
                    }
                })
                .onOpenURL { url in
                    NaverThirdPartyLoginConnection.getSharedInstance().receiveAccessToken(url)
                    print(#function)
                    print(url)
                }
        }
        
    }
}
