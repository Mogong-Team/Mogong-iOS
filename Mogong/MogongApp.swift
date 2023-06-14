//
//  MogongApp.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct MogongApp: App {
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var studyViewModel = StudyViewModel()
    @StateObject var rankViewModel = RankViewModel()
    @StateObject var userViewModel = UserViewModel()
    
    init() {
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: "ad63ed85978c701f2e947c5e85b1215e")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loginViewModel)
                .environmentObject(studyViewModel)
                .environmentObject(rankViewModel)
                .environmentObject(userViewModel)
                // onOpenURL()을 사용해 커스텀 URL 스킴 처리
                .onOpenURL(perform: { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        AuthController.handleOpenUrl(url: url)
                    }
                })
        }
    }
}
