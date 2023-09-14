//
//  ApplicationDetailView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/10.
//

import SwiftUI

struct ApplicationDetailView: View {
    @EnvironmentObject var viewModel: ApplicationViewModel
    @EnvironmentObject var studyViewModel: StudyViewModel
    @Environment(\.dismiss) var dismiss
    
    var application: Application
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack(spacing: 10) {
                        Image("userimage_basic")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .scaledToFit()
                            .clipShape(Circle())
                            .foregroundColor(.gray)
                        
                        Text(application.user.username)
                            .font(.pretendard(weight: .bold, size: 28))
                            .foregroundColor(Color(hexColor: "494949"))
                        
                        Text("\(application.position.rawValue) 지원!")
                            .padding(.vertical, 5)
                            .padding(.horizontal, 15)
                            .font(.pretendard(weight: .semiBold, size: 16))
                            .foregroundColor(.white)
                            .background(Color.main)
                            .cornerRadius(10)
                    }
                    .padding(.top, 10)
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
                Button {
                    viewModel.rejectJoin(study: studyViewModel.selectedStudy) {
                        studyViewModel.getStudyWithId {
                            dismiss()
                        }
                    }
                } label: {
                    Text("가입 거절")
                        .font(.pretendard(weight: .semiBold, size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(Color(hexColor: "C5C5C5"))
                        .cornerRadius(21)
                }
                
                ActionButton("가입 허가") {
                    viewModel.approveJoin(study: studyViewModel.selectedStudy) {
                        studyViewModel.getStudyWithId {
                            dismiss()
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

struct ApplicationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationDetailView(application: Application.application1)
        .environmentObject(ApplicationViewModel())
    }
}
