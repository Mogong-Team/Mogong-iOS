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
                
                ForEach(Application.applications) { application in
                    ApplicationList(application: application)
                }
            }
            .padding(.vertical, 10)
        }
        .padding(.horizontal, 20)
        .onAppear {
            viewModel.getStudyApplication(studyId: studyViewModel.selectedStudy.id)
        }
    }
}

struct ApplicationListView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationListView(user: User.user1)
            .environmentObject(ApplicationViewModel())
    }
}

struct ApplicationList: View {
    @EnvironmentObject var viewModel: ApplicationViewModel
    
    var application: Application
    
    var body: some View {
        NavigationLink {
            ApplicationDetailView(application: application)
        } label: {
            ZStack {
                ZStack(alignment: .bottomLeading) {
                    Rectangle()
                        .frame(width: 80, height: 125)
                        .cornerRadius(16)
                    
                    Rectangle()
                        .frame(width: 350, height: 110)
                        .cornerRadius(16)
                }
                .foregroundColor(Color(red: 0, green: 0.78, blue: 0.96))
                
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Text("2023.7.3")
                    }
                    
                    HStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .scaledToFit()
                            .clipShape(Circle())
                            .foregroundColor(.gray)
                    }

                    VStack {
                        Text("프론트엔드")
                            .padding(.vertical, 3)
                            .padding(.horizontal, 5)
                            .font(.pretendard(weight: .semiBold, size: 14))
                            .foregroundColor(.white)
                            .background(.yellow)
                            .cornerRadius(10)
                    }
//                    .padding(5)
                    
                    HStack {
                        Text("녹차라떼샷추가")
                            .font(.pretendard(weight: .bold, size: 20))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text("#스터디비기너")
                            .font(.pretendard(weight: .bold, size: 20))
                            .foregroundColor(.gray)
                    }//HStack
                    .padding(5)
                    .padding(.bottom, 20)
                }//VStack
                .padding(.horizontal, 12)
            }//ZStack
            .frame(height: 140)
        }
    }
}
