//
//  UsernameView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/15.
//

import SwiftUI

struct UsernameView: View {
    @Environment(\.dismiss) var dismiss
    @State private var username = "123"
    @State private var isUsernameAvailable = false
    @State private var isUsernameChecked = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("모공에 오신걸\n환영합니다\n닉네임을 설정해주세요.")
                .font(
                    Font.custom("Pretendard", size: 32)
                        .weight(.bold)
                )
                .padding(.top)

            VStack(alignment: .leading) {
                HStack(spacing: 15) {
                    TextField("10글자 이내로 설정해주세요.", text: $username)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(.gray, lineWidth: 1)
                                .frame(width: 270, height: 44)
                        }
                    
                    Button {
                        checkUsernameAvailability()
                    } label: {
                        Text("중복확인")
                            .frame(width: 88, height: 44)
                            .foregroundColor(.white)
                            .background(Color(red: 0, green: 0.78, blue: 0.96))
                            .cornerRadius(7)
                    }
                }
                .frame(width: 370)
                
                if isUsernameChecked {
                    Text(isUsernameAvailable ? "사용 가능한 아이디입니다." : "사용 불가능한 아이디입니다.")
                        .foregroundColor(isUsernameAvailable ? .green : .red)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    func checkUsernameAvailability() {
        isUsernameAvailable = !username.isEmpty
        isUsernameChecked = true
    }
}

struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameView()
    }
}

