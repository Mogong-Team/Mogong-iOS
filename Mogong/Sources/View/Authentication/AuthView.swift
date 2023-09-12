//
//  AuthView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("mogongLogo")
                    .padding(20)
                Image("titleimage")
                
                VStack(spacing: 15) {
                    Text("지금 모공과 함께\n스터디를 시작하세요!")
                        .font(.pretendard(weight: .bold, size: 20))
                        .foregroundColor(Color(hexColor: "494949"))
                        .multilineTextAlignment(.center)
                    
                    Text("책임감 있는 팀원들을 만나봐요!")
                        .font(.pretendard(weight: .medium, size: 15))
                        .foregroundColor(Color(hexColor: "999696"))
                }
                .padding(20)
                Text("3초만에 로그인하기")
                    .font(.pretendard(weight: .bold, size: 15))
                    .foregroundColor(Color(hexColor: "494949"))
                    .padding(20)
                
                SocialLogin()
                    .padding()
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $viewModel.presentNextView) {
                UsernameView()
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environmentObject(AuthViewModel())
    }
}
