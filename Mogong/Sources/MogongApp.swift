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
import GoogleSignIn
//import GoogleSignInSwift

@main
struct MogongApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var studyViewModel = StudyViewModel()
    @StateObject var rankViewModel = RankViewModel()
    @StateObject var userViewModel = UserViewModel()
    @StateObject var chatViewModel = ChatViewModel()
    @StateObject var applicationViewModel = ApplicationViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .environmentObject(studyViewModel)
                .environmentObject(rankViewModel)
                .environmentObject(userViewModel)
                .environmentObject(chatViewModel)
                .environmentObject(applicationViewModel)
                // SceneDelegate 설정
                .onOpenURL(perform: { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        AuthController.handleOpenUrl(url: url)
                    }
                })
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .onOpenURL { url in
                    NaverThirdPartyLoginConnection
                        .getSharedInstance()
                        .receiveAccessToken(url)
                }
        }
    }
}
