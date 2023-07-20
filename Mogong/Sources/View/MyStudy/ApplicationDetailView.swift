//
//  ApplicationDetailView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/10.
//

import SwiftUI

struct ApplicationDetailView: View {
    @EnvironmentObject var viewModel: ApplicationViewModel
    @Environment(\.dismiss) var dismiss
    
    var application: Application
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack(spacing: 10) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .scaledToFit()
                            .clipShape(Circle())
                            .foregroundColor(.gray)
                        
                        Text(application.user.username)
                            .font(.pretendard(weight: .bold, size: 28))
                        
                        Text("\(application.field.rawValue) 지원")
                            .padding(.vertical, 3)
                            .padding(.horizontal, 20)
                            .font(.pretendard(weight: .regular, size: 16))
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 30)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 20) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("간단한 자기소개")
                                    .font(Font.system(size: 18, weight: .bold))
                                Text(application.introduction)
                                    .font(Font.system(size: 16, weight: .regular))
                                    .foregroundColor(.gray)
                            }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("프로젝트 경험 여부")
                                    .font(Font.system(size: 18, weight: .bold))
                                Text(application.experience)
                                    .font(Font.system(size: 16, weight: .regular))
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                    }
                }
                .padding(.vertical, 10)
            }
            
            HStack {
                SelectButton(title: "가입 거절", state: .unselected) {
                    dismiss()
                }
                
                SelectButton(title: "가입 허가", state: .selected) {
                    dismiss()
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

struct ApplicationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationDetailView(application: Application(
            user: User(id: "1", name: "김민수", email: "a@gmail.com", username: "민수민수"),
            title: "backend 지원합니다.",
            field: .backend,
            introduction: "안녕하세요",
            experience: "없습니다.")
        )
        .environmentObject(ApplicationViewModel())
    }
}
