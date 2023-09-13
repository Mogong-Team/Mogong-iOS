//
//  CompleteSignInView.swift
//  Mogong
//
//  Created by 심현석 on 2023/08/15.
//

import SwiftUI

struct CompleteSignInView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("\(viewModel.username)님\n모공에 오신 걸\n환영합니다!")
                .font(.pretendard(weight: .bold, size: 30))
                .lineSpacing(15)
                .multilineTextAlignment(.center)
                .padding(.top, 250)
            
            Spacer()
            
            ActionButton("시작하기") {
                viewModel.resetUsername()
            }
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden()
    }
}

struct CompleteSignInView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteSignInView()
            .environmentObject(AuthViewModel())
    }
}
