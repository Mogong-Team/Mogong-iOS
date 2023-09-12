//
//  StudyDeatailView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/26.
//

import SwiftUI

struct StudyDetailView: View {
    @EnvironmentObject var viewModel: StudyViewModel
    @EnvironmentObject var applicationViewModel: ApplicationViewModel
    
    @State private var showAlert = false
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    Introduction()
                    InfinityRectangleText(title: "프로젝트 소개",
                                          content: viewModel.selectedStudy.introduction)
                    InfinityRectangleText(title: "이런 분을 모셔요!",
                                          content: viewModel.selectedStudy.memberPreference)
                    InfinityRectangleText(title: "스터디 최종 목표",
                                          content: viewModel.selectedStudy.goal)
                    CurrentMember()
                    
                    if viewModel.checkMember {
                        if viewModel.checkHost {
                            ActionButton("스터디 수정하기") {
                                viewModel.stateForCreateStudy = .update
                                viewModel.showCreateStudyOnDetail = true
                            }
                            .padding(.horizontal, 20)
                        } else {
                            ActionButton("가입 완료") {
                            }
                            .disabled(true)
                            .padding(.horizontal, 20)
                        }
                    } else {
                        if viewModel.checkSubimt {
                            CancelButton("지원 취소하기") {
                                showAlert = true
                            }
                            .padding(.horizontal, 20)
                        } else {
                            ActionButton("지원서 쓰러가기") {
                                viewModel.presentApplicationStudy = true
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }
                .id(1)
                .padding(.bottom, 10)
            }
            .onAppear {
                proxy.scrollTo(1, anchor: .top)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Image(systemName: "xmark")
                    .onTapGesture {
                        viewModel.showStudyDetail = false
                        viewModel.showStudyDetailOnHomeNew = false
                        viewModel.showStudyDetailOnHomeBookmark = false
                    }
            }
        }
        .navigationDestination(isPresented: $viewModel.presentApplicationStudy) {
            ApplicationView()
        }
        .fullScreenCover(isPresented: $viewModel.showCreateStudyOnDetail) {
            NavigationStack {
                CreateStudy()
            }
        }
        .onAppear {
            viewModel.checkStudyDetailState()
        }
        .alert("지원 취소하기", isPresented: $showAlert) {
            Button("확인") {
                applicationViewModel.deleteApplication(study: viewModel.selectedStudy) {
                    viewModel.getStudyWithId() {
                        viewModel.checkStudyDetailState()
                    }
                }
            }
            
            Button(role: .cancel) {
            } label: {
                Text("취소")
            }
        } message: {
            Text("정말로 지원을 취소하시겠습니까?")
        }
    }
}

struct Introduction: View {
    @EnvironmentObject var viewModel: StudyViewModel
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            //TODO: 북마크 api
            HStack {
                RoundRectangleLabel(
                    text: "\(viewModel.selectedStudy.bookMarkedUsers.count)",
                    image: Image(systemName: "bookmark.fill"),
                    background: Color.main)
                //.padding(.bottom, 10)
                
                Image(systemName:
                      viewModel.selectedStudy.bookMarkedUsers.contains(UserViewModel.shared.currentUser.id)
                      ? "heart.fill"
                      : "heart")
                .foregroundColor(.red)
                .onTapGesture {
                    viewModel.updateBookmark()
                }
                
                Spacer()
            }
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
                DetailContent(
                    title: "모집 현황",
                    content: "\(viewModel.selectedStudy.currentMembers.count) / \(viewModel.selectedStudy.numberOfRecruits)")
            } else if viewModel.selectedStudy.category == .projectStudy {
                DetailContent(title: "수익화 목적",
                              content: viewModel.selectedStudy.revenuePurpose?.rawValue ?? "")
                DetailContent(
                    title: "모집 현황",
                    content: "\(viewModel.selectedStudy.currentMembers.count) / \(viewModel.numberOfRecruits(study: viewModel.selectedStudy))")
                
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
                let currentMembers = viewModel.selectedStudy.currentMembers
                let currentCount = currentMembers.filter { $0.position == position.position }.count
                
                RecruitmentStateContent(position: position.position,
                                        currnet: currentCount,
                                        required: position.requiredCount)
            }
        }
    }
}

struct RecruitmentStateContent: View {
    @EnvironmentObject var viewModel: StudyViewModel
    @EnvironmentObject var applicationViewModel: ApplicationViewModel
    var position: Position
    var currnet: Int
    var required: Int
    
    var body: some View {
        HStack {
            Text(position.rawValue)
                .font(.pretendard(weight: .bold, size: 16))
            Spacer()
            Text("\(currnet) / \(required)")
                .font(.pretendard(weight: .semiBold, size: 20))
            
            if !viewModel.checkMember {
                if !viewModel.checkSubimt {
                    Text("지원 하기")
                        .font(.pretendard(weight: .semiBold, size: 16))
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
                        .background(Color.main)
                        .cornerRadius(8)
                        .onTapGesture {
                            viewModel.presentApplicationStudy = true
                            applicationViewModel.position = position
                        }
                } else {
                    Text("지원 완료")
                        .font(.pretendard(weight: .semiBold, size: 16))
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
                        .background(Color(hexColor: "C5C5C5"))
                        .cornerRadius(8)
                }
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
                .environmentObject(ApplicationViewModel())
        }
    }
}

