//
//  LoginView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/15.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
            VStack(spacing: 10) {
                TextField("이메일 주소", text: $email)
                    .padding()
                    .autocapitalization(.none)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 1)
                    }
                
                SecureField("비밀번호", text: $password)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 1)
                    }

                Button {
                    
                } label: {
                    Text("로그인")
                        .frame(width: 300, height: 50)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(5)
                }
            }
            .frame(width: 300)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
