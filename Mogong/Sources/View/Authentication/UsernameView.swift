//
//  UsernameView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/15.
//

import SwiftUI

struct UsernameView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var presentCompleteSignInView = false

    var isCompleted: Bool {
        return authViewModel.username.count > 3
        && authViewModel.username.count < 11
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("모공에 오신걸\n환영합니다\n닉네임을 설정해주세요.")
                .font(.pretendard(weight: .bold, size: 32))
                .foregroundColor(Color(hexColor: "494949"))
                .lineSpacing(5)
                .padding(.top, 120)
                .padding(.bottom, 20)
            
            HStack(spacing: 10) {
                TextField("4글자 이상 10글자 이내로 설정해주세요.", text: $authViewModel.username)
                    .font(.pretendard(weight: .regular, size: 14))
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .overlay {
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(Color(hexColor: "C5C5C5"), lineWidth: 1)
                    }
                
//                Button {
//                    checkUsernameIsAvailable()
//                } label: {
//                    Text("중복 확인")
//                        .font(.pretendard(weight: .regular, size: 16))
//                        .foregroundColor(.white)
//                        .frame(width: 88, height: 44)
//                        .background(isUsernameLengthValid
//                                    ? Color.main
//                                    : Color(uiColor: .systemGray4))
//                        .cornerRadius(7)
//                }
//                .disabled(!isUsernameLengthValid)
            }
            
//            if isUsernameAvailable == false {
//                Text("사용 불가능한 아이디입니다.")
//                    .font(.pretendard(weight: .regular, size: 16))
//                    .foregroundColor(.red)
//            } else if isUsernameAvailable == true {
//                Text("사용 가능한 아이디입니다.")
//                    .font(.pretendard(weight: .regular, size: 16))
//                    .foregroundColor(.blue)
//            }
            
//            if isUsernameChecked {
//                Text(isUsernameAvailable ? "사용 가능한 아이디입니다." : "사용 불가능한 아이디입니다.")
//                    .foregroundColor(isUsernameAvailable ? .green : .red)
//            }
            
            Spacer()
            
            ActionButton("다음") {
                authViewModel.updateUsername()
                presentCompleteSignInView = true
            }
            .disabled(!isCompleted)
            .navigationDestination(isPresented: $presentCompleteSignInView) {
                CompleteSignInView()
            }
        }
        .padding(.horizontal, 20)
        .onDisappear {
            authViewModel.resetUsername()
        }
    }
    
    func checkUsernameIsAvailable() {
        //TODO: 중복 확인
//        isUsernameAvailable = !viewModel.username.isEmpty
//        isUsernameChecked = true
    }
}

struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            UsernameView()
                .environmentObject(AuthViewModel())
        }
    }
}
