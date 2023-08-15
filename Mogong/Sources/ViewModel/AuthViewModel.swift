//
//  AuthViewModel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI
import Combine
import Alamofire
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices

class AuthViewModel: NSObject, ObservableObject  {
    @Published var username: String = ""
    @Published var isUsernameAvailable: Bool?
    
    @Published var loginData = Login(name: "실패", email: "실패")
    @Published var isLoggedIn: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()

    func checkIfLoggedIn() {
        
    }
    
    func postAPI(name: String, email: String) {
        let newLogin = Login(name: name, email: email)
        self.loginData = newLogin
    }
    
    func resetUsername() {
        username = ""
    }
}

// MARK: - 카카오 로그인 extension

extension AuthViewModel {
    
    func loginWithKakaoTalk() {
        // 발급된 토큰이 있는지 확인
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { _, error in
                // 토큰이 유효하지 않은 경우
                if let error = error {
                    // 카카오톡에서 토큰 발급하고 로그인
                    self.openKakaoService()
                    
                // 토큰이 유효한 경우
                } else {
                    // 유저 정보 가져오기
                    self.getKakaoUserInfo()
                }
            }
        } else {
            self.openKakaoService()
        }
    }
    
    func openKakaoService() {
        // isKakaoTalkLoginAvailable() : 카톡 설치 되어있으면 true
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("카카오톡 로그인 성공")
                    _ = oauthToken
                    // 유저 정보 가져오기
                    self.getKakaoUserInfo()
                }
            }
        } else {
            // 카톡 없으면 -> 웹에서 카카오 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                }
                else {
                    print("웹에서 카카오 계정으로 로그인 성공")
                    _ = oauthToken
                    // 유저 정보 가져오기
                    self.getKakaoUserInfo()
                }
            }
        }
    }
            
    func getKakaoUserInfo(){
        UserApi.shared.me { user, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("카카오톡 유저 정보 가져오기 성공")
                
                _ = user
                
                guard let nickname = user?.kakaoAccount?.profile?.nickname else { return }
                guard let email = user?.kakaoAccount?.email else { return }
                
                self.postAPI(name: nickname, email: email)
            }
        }
    }
}

// MARK: - 구글 로그인 extension

extension AuthViewModel {
    func loginWithGoogle() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                print("구글 로그인 성공")
                guard let name = user?.profile?.name else { return }
                guard let email = user?.profile?.email else { return }
                
                self.postAPI(name: name, email: email)
            }
        } else {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }

            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
                if let error = error {
                    print(error.localizedDescription)
                    print("구글 로그인 실패")
                } else {
                    print("구글 로그인 성공")
                    guard let name = result?.user.profile?.name else { return }
                    guard let email = result?.user.profile?.email else { return }
                    
                    self.postAPI(name: name, email: email)
                    
                    // 백엔드에 토큰 보내기
                    guard let result = result else { return }
                    
                    result.user.refreshTokensIfNeeded { user, error in
                        if let error = error {
                            print(error.localizedDescription)
                            print("토큰 전달 실패")
                        }
                        print("토큰 전달 성공")
                        guard let idToken = user?.idToken else { return }
                        // Post API
                        print(idToken)
                    }
                }
            }
        }
    }
}

// MARK: - 애플 로그인 extension

extension AuthViewModel: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    // Apple 로그인을 요청하는 메서드
    func loginWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    // 인증 UI를 표시할 앵커를 반환하는 메서드
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.windows.first!
    }
    
    // 인증이 성공적으로 완료된 후 호출되는 메서드
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            print("애플 로그인 성공")
            
            let name = appleIDCredential.fullName // nil
            let email = appleIDCredential.email // nil
            
            print(name?.givenName)
            print(email)

            //self.postAPI(name: name, email: email)
        }
    }
    
    // 인증이 실패하거나 사용자가 취소한 경우 호출되는 메서드
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
        print("애플 로그인 실패")
    }
}

// MARK: - 네이버 로그인 extension

extension AuthViewModel: NaverThirdPartyLoginConnectionDelegate   {
    func  loginWithNaver() {
        // 네이버 앱이 깔려져 있을때
        if NaverThirdPartyLoginConnection
            .getSharedInstance()
            .isPossibleToOpenNaverApp()
        {
            NaverThirdPartyLoginConnection.getSharedInstance().delegate = self
            NaverThirdPartyLoginConnection
                .getSharedInstance()
                .requestThirdPartyLogin() // 로그인 요청
            print(#function)
        }
        // 네이버 앱이 안깔려져 있을때 -> 웹에서 로그인 요청
        else {
            NaverThirdPartyLoginConnection
                .getSharedInstance()
                .requestThirdPartyLogin()
        }
    }
    
    // 로그인에 성공했을 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("로그인 성공")
        getNaverInfo()
    }
    
    // 접근 토큰 갱신
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        
    }
    
    // 로그아웃 할 경우 호출(토큰 삭제)
    func oauth20ConnectionDidFinishDeleteToken() {
        print("로그아웃")
    }
    
    // 에러 처리
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("Error: \(error.localizedDescription)")
    }
    
    // 네이버 로그인 정보 가져오기
    func getNaverInfo() {
        guard let isValidAccessToken = naverLoginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        if !isValidAccessToken {
            return
        }
        
        guard let tokenType = naverLoginInstance?.tokenType else { return }
        guard let accessToken = naverLoginInstance?.accessToken else { return }
        
        let urlStr = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: urlStr)!
        
        let authorization = "\(tokenType) \(accessToken)"
        
        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        
        req.responseJSON { response in
            guard let result = response.value as? [String: Any] else { return }
            guard let object = result["response"] as? [String: Any] else { return }
            guard let name = object["name"] as? String else { return }
            guard let email = object["email"] as? String else { return }
            guard let id = object["id"] as? String else {return}
            
            self.loginData = Login(name: name, email: email)
            print(self.loginData)
        }
    }
}
