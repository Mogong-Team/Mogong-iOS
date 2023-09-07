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

// init()으로 대체 가능 -> 앱 실행시에 최초 1회 실행이 필요한 로직
class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        //MARK: - 카카오
        
        // Kakao SDK 초기화
        KakaoSDK.initSDK(appKey: "ad63ed85978c701f2e947c5e85b1215e")
        
        //MARK: - 구글
        
        let clientID = "445750195734-da9230k2r5min42eioscrp2uibiei6ch.apps.googleusercontent.com"
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
        
        //MARK: - 네이버

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
                
        return true
    }
}
