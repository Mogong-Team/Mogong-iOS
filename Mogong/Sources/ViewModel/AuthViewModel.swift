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
    @Published var email: String = ""
    @Published var username: String = ""
    @Published var isUsernameAvailable: Bool?
    @Published var isLoggedIn: Bool = false
    @Published var presentNextView: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()

    func checkIfLoggedIn() {
        //TODO: 앱 시작시 로그인 여부 확인
    }
    
    func postUserInfo(email: String, username: String) {
        //TODO: 소셜로그인 회원가입 정보 POST
    }
    
    func resetUsername() {
        username = ""
    }
}

// MARK: - 카카오 로그인 extension

extension AuthViewModel {
    
    func loginWithKakaoTalk() {
        // 발급된 토큰이 있는 경우
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { _, error in
                // 토큰이 유효하지 않은 경우
                if error != nil {
                    // 새로운 토큰 발급
                    self.openKakaoService()
                    print("KaKao: 1")
                // 토큰이 유효한 경우
                } else {
                    // 유저 정보 가져오기
                    self.getKakaoUserInfo()
                    print("KaKao: 2")
                }
            }
        // 발급된 토큰이 없는 경우
        } else {
            print("KaKao: 3")
            self.openKakaoService()
        }
    }
    
    func openKakaoService() {
        // isKakaoTalkLoginAvailable() : 카톡 설치 되어있으면 true
        if (UserApi.isKakaoTalkLoginAvailable()) {
            print("KaKao: 4")
            // 카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                print("KaKao: 5")
                if let error = error {
                    print("KaKao: 6")
                    print(error)
                }
                else {
                    print("KaKao: 7")
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
                guard let email = user?.kakaoAccount?.email else { return }
                self.email = email
                self.presentNextView = true
            }
        }
    }
}

// MARK: - 구글 로그인 extension

extension AuthViewModel {
    func loginWithGoogle() {
        print("Google: 1")
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            print("Google: 1")
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                print("구글 로그인 성공")
                guard let email = user?.profile?.email else { return }
                self.email = email
                self.presentNextView = true
            }
        } else {
            print("Google: 3")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            print("Google: 4")
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
                if let error = error {
                    print(error.localizedDescription)
                    print("구글 로그인 실패")
                } else {
                    print("구글 로그인 성공")
                    guard let email = result?.user.profile?.email else { return }
                    self.email = email

                    // 백엔드에 토큰 보내기
                    guard let result = result else { return }
                    
                    result.user.refreshTokensIfNeeded { user, error in
                        if let error = error {
                            print(error.localizedDescription)
                            print("토큰 전달 실패")
                        }
                        print("토큰 전달 성공")
                        guard let idToken = user?.idToken else { return }
                        //TODO: 토큰 전달 API?
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
        print("Apple: 1")
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
        print("Apple: 2")
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            print("Apple: 3")
            print("애플 로그인 성공")
            
            guard let email = appleIDCredential.email else { return } // nil
            self.email = email
            self.presentNextView = true
        }
    }
    
    // 인증이 실패하거나 사용자가 취소한 경우 호출되는 메서드
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple: 4")
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
            
            self.email = email
        }
    }
}
