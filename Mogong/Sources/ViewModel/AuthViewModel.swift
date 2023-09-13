//
//  AuthViewModel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI
import Alamofire
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices
import Firebase
import FirebaseAuth
import FirebaseFirestore

extension AuthViewModel {
    enum signSate {
        case signIn
        case signOut
    }
    
    enum signPlatform {
        case none
        case kakao
        case google
        case apple
    }
}

class AuthViewModel: NSObject, ObservableObject  {
    
    @Published var username: String = ""
    @Published var isUsernameAvailable: Bool?
    @Published var presentInputUsernameView: Bool = false
    
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    @Published var signState: signSate = .signOut
    @Published var signPlatform: signPlatform = .none
    @Published var currentUser: User?

    func resetUsername() {
        username = ""
    }
    
    func updateUsername() {
        guard var user = currentUser else { return }
        user.username = username
        
        UserService.updateUser(user: user) { error in
            if let error = error {
                print("닉네임 입력 후 유저 정보 업데이트 실패: ", error.localizedDescription)
                return
            }
            print("닉네임 입력 후 유저 정보 업데이트 성공")
        }
        
        self.currentUser?.username = username
    }
    
    func getUser(uid: String) {
        UserService.getUser(userId: uid) { result in
            switch result {
            case .success(let user):
                UserViewModel.shared.currentUser = user
                self.currentUser = user
            case .failure(let error):
                print("유저 정보 가져오기 실패: ", error.localizedDescription)
            }
        }
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
                // 토큰이 유효한 경우
                } else {
                    // 유저 정보 가져오기
                    self.getKakaoUserInfo()
                }
            }
        // 발급된 토큰이 없는 경우
        } else {
            self.openKakaoService()
        }
    }
    
    func openKakaoService() {
        // isKakaoTalkLoginAvailable() : 카톡 설치 되어있으면 true
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
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
                guard let email = user?.kakaoAccount?.email else { return }
                
                //self.email = email
                //self.presentInputUsernameView = true
            }
        }
    }
}

// MARK: - 구글 로그인 extension

extension AuthViewModel {
    
    // google 로그인 절차
    func signInGoogle() {
        // 1
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error)
            }
        } else {
            // 2
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            // 3
            let configuration = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = configuration
            
            // 4
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
            
            // 5
            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) {[unowned self] result, error in
                guard let result = result else { return }
                authenticateUser(for: result.user, with: error)
            }
        }
    }
    
    // firebase 로그인 절차
    func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        // 1
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        // 2
        guard let accessToken = user?.accessToken.tokenString, let idToken = user?.idToken?.tokenString else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        // 3
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.signState = .signIn
                self.signPlatform = .google
                self.getOrCreateUser(authResult: result)
            }
        }
    }
    
    // google 로그인 완료 후 유저 정보 저장 및 받아오는 절차
    func getOrCreateUser(authResult: AuthDataResult?) {
        guard let authResult = authResult else { return }
        guard let email = authResult.user.email else { return }
        let uid = authResult.user.uid
                
        Firestore.firestore().collection("users").document(uid).getDocument { (document, error) in
            if let error = error {
                print("users - document 접근 실패: ", error.localizedDescription)
                return
            }
            
            if let document = document, document.exists {
                // 문서가 존재하면 유저 정보 파싱
                do {
                    let data = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                    let user = try JSONDecoder().decode(User.self, from: data)
                    self.currentUser = user
                } catch let error {
                    print("JSON 인코딩 오류: \(error)")
                }
            } else {
                // 문서가 존재하지 않으면 새 유저 정보를 저장
                let user = User(id: uid, email: email)
                
                UserService.saveUser(user: user) { error in
                    if let error = error {
                        print("새로운 유저 저장 실패: ", error.localizedDescription)
                    }
                }
                self.currentUser = user
            }
        }
    }
    
    // google 로그아웃 절차
    func signOutGoogle() {
        // 1
        GIDSignIn.sharedInstance.signOut()
        
        do {
            // 2
            try Auth.auth().signOut()
            self.signState = .signOut
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func signInWithGoogle() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                print("구글 로그인 성공")
                guard let email = user?.profile?.email else { return }
                //self.email = email
                //self.presentInputUsernameView = true
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
                    guard let email = result?.user.profile?.email else { return }
                    //self.email = email
                    //self.presentInputUsernameView = true
                    
                    // 백엔드에 토큰 보내기
                    guard let result = result else { return }
                    
                    result.user.refreshTokensIfNeeded { user, error in
                        if let error = error {
                            print(error.localizedDescription)
                            print("토큰 전달 실패")
                        }
                        print("토큰 전달 성공")
                        guard let idToken = user?.idToken?.tokenString else { return }
                        //TODO: 토큰 전달 API?
                    }
                }
            }
        }
    }
    
    func signOutWithGoogle() {
        
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
            //self.presentInputUsernameView = true
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
        }
    }
}
