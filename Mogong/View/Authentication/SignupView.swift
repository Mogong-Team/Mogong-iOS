//
//  SignupView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/15.
//

import SwiftUI

struct SignupView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        VStack {
            Text("Mogong")
                .font(.title)
            
            VStack(spacing: 10) {
                TextField("성명", text: $name)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 1)
                    }
                
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
                
                SecureField("비밀번호 확인", text: $confirmPassword)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.gray, lineWidth: 1)
                    }
                
                NavigationLink {
                    LoginView()
                } label: {
                    Text("가입하기")
                        .frame(width: 300, height: 50)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(5)
                }
            }
            .frame(width: 300)
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
