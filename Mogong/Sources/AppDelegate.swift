//
//  AppDelegate.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/29.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import NaverThirdPartyLogin
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    // init()으로 대체 가능 -> 앱 실행시에 최초 1회 실행이 필요한 로직
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: "ad63ed85978c701f2e947c5e85b1215e")
        
        // Naver SDK 초기화
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        // 네이버 앱으로 로그인 허용
        instance?.isNaverAppOauthEnable = true
        // 브라우저 로그인 허용
        instance?.isInAppOauthEnable = true
        // NaverThirdPartyConstantsForApp.h에 선언한 상수 등록
        instance?.serviceUrlScheme = kServiceAppUrlScheme
        instance?.consumerKey = kConsumerKey
        instance?.consumerSecret = kConsumerSecret
        instance?.appName = kServiceAppName
        
        let clientID = "445750195734-da9230k2r5min42eioscrp2uibiei6ch.apps.googleusercontent.com"
        let serverClientID = "com.googleusercontent.apps.445750195734-da9230k2r5min42eioscrp2uibiei6ch"
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID, serverClientID: serverClientID)
        
        
        
        return true
    }
}
