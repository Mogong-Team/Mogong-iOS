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
                
                SocialLogin()
                    .padding()
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $viewModel.presentInputUsernameView) {
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
