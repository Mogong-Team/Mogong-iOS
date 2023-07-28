//
//  StudyDeatailView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/26.
//

import SwiftUI

struct StudyDetailView: View {
    @EnvironmentObject var viewModel: StudyViewModel
    @State private var isPresented: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20 ){
                Introduction()
                InfinityRectangleText(title: "프로젝트 소개",
                                      content: viewModel.selectedStudy.introduction)
                InfinityRectangleText(title: "이런 분을 모셔요!",
                                      content: viewModel.selectedStudy.memberPreference)
                InfinityRectangleText(title: "스터디 최종 목표",
                                      content: viewModel.selectedStudy.goal)
                CurrentMember()
                ActionButton("지원서 쓰러가기") {
                    isPresented = true
                }
                .padding(.horizontal, 20)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
                    .onTapGesture {
                        viewModel.presentStudyDetail = false
                    }
            }
        }
        .navigationDestination(isPresented: $isPresented) {
            ApplicationView()
        }
    }
}

struct Introduction: View {
    @EnvironmentObject var viewModel: StudyViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            RoundRectangleLabel(text: "1000",
                                image: Image(systemName: "bookmark.fill"),
                                background: Color.main)
            .padding(.bottom, 10)
            
            Text(viewModel.selectedStudy.title)
                .font(.pretendard(weight: .bold, size: 28))
                .multilineTextAlignment(.leading)
                .padding(.bottom, 20)
            
            StudyDetail()
        }
        .padding(.horizontal, 20)
    }
}

struct StudyDetail: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            DetailContent(title: "예상 기간",
                          content: "\(viewModel.selectedStudy.durationOfMonth)달")
            DetailContent(title: "모집 형태",
                          content: viewModel.selectedStudy.loaction.rawValue)
            
            if viewModel.selectedStudy.category == .generalStudy {
                HStack(spacing: 5) {
                    Text("사용 언어")
                        .font(.pretendard(weight: .bold, size: 15))
                        .foregroundColor(.gray)
                    
                    ForEach(viewModel.selectedStudy.languages, id: \.self) { language in
                        HashtagView(text: language.rawValue)
                    }
                }
                DetailContent(title: "모집 현황",
                              content: "\(viewModel.numberOfRecruits(study: viewModel.selectedStudy)) / \(viewModel.numberOfRecruits(study: viewModel.selectedStudy))")
            } else if viewModel.selectedStudy.category == .projectStudy {
                DetailContent(title: "수익화 목적",
                              content: viewModel.selectedStudy.revenuePurpose?.rawValue ?? "")
                DetailContent(title: "모집 현황", content: "")
                RecruitmentState()
            }
        }
    }
}

struct RecruitmentState: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(viewModel.selectedStudy.positionInfos, id: \.self) { position in
                RecruitmentStateContent(position: position.position.rawValue,
                                        currnet: position.currentCount,
                                        required: position.requiredCount)
            }
        }
    }
}

struct RecruitmentStateContent: View {
    var position: String
    var currnet: Int
    var required: Int
    
    var body: some View {
        HStack {
            Text(position)
                .font(.pretendard(weight: .bold, size: 16))
            Spacer()
            Text("\(currnet) / \(required)")
                .font(.pretendard(weight: .semiBold, size: 20))
            NavigationLink {
                ApplicationView()
            } label: {
                Text("지원하기")
                    .font(.pretendard(weight: .semiBold, size: 16))
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
                    .background(Color.main)
                    .cornerRadius(8)
            }
        }
    }
}

struct DetailContent: View {
    var title: String
    var content: String
    
    var body: some View {
        HStack(spacing: 10) {
            Text(title)
                .font(.pretendard(weight: .bold, size: 15))
                .foregroundColor(Color(hexColor: "727272", opacity: 0.7))
            
            Text(content)
                .font(.pretendard(weight: .bold, size: 15))
                .foregroundColor(Color(hexColor: "3F3C3C"))
            
            Spacer()
        }
    }
}

struct InfinityRectangleText: View {
    var title: String
    var content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(title)
                .font(.pretendard(weight: .bold, size: 20))
            
            Text(content)
                .font(.pretendard(weight: .regular, size: 13))
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(hexColor: "ECFBFF"))
    }
}

struct CurrentMember: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("스터디원")
                .font(.pretendard(weight: .bold, size: 20))
            
            LazyVGrid(columns: [GridItem(), GridItem()],
                      alignment: .center,
                      spacing: nil) {
                ForEach(viewModel.selectedStudy.currentMembers,
                        id: \.self)
                { member in
                    MemberVstack(member: member, isHost: false)
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

struct StudyDeatailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StudyDetailView()
                .environmentObject(StudyViewModel())
        }
    }
}

