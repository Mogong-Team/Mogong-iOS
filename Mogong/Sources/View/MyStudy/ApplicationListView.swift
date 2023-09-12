//
//  ApplicationListView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/10.
//

import SwiftUI

struct ApplicationListView: View {
    @EnvironmentObject var viewModel: ApplicationViewModel
    @EnvironmentObject var studyViewModel: StudyViewModel
    
    var user: User
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("지원자 리스트")
                            .font(.pretendard(weight: .semiBold, size: 24))
                            .padding(.bottom, 2)
                        Text("내 스터디에 지원한 지원자들을 살펴보시고\n가입 여부를 결정해 주세요!")
                            .font(.pretendard(weight: .medium, size: 18))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.bottom, 45)
                
                if viewModel.applications.isEmpty {
                    Spacer()
                        .frame(height: 200)
                    Text("지원자가 없습니다.")
                    .font(.pretendard(weight: .semiBold, size: 18))
                } else {
                    ForEach(viewModel.applications) { application in
                        ApplicationCell(application: application)
                            .onTapGesture {
                                viewModel.selectedApplication = application
                                viewModel.presentApplicationDetailView = true
                            }
                    }
                }
            }
            .padding(.vertical, 10)
        }
        .padding(.horizontal, 20)
        .onAppear {
            viewModel.getStudyApplication(study: studyViewModel.selectedStudy)
        }
        .navigationDestination(isPresented: $viewModel.presentApplicationDetailView) {
            ApplicationDetailView(application: viewModel.selectedApplication)
        }
    }
}

struct ApplicationListView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationListView(user: User.user1)
            .environmentObject(ApplicationViewModel())
    }
}
