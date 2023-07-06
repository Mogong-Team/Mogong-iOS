//
//  MyStudyView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/21.
//

import SwiftUI

enum StudyState {
    case ongoing
    case completed
}

struct MyStudyView: View {
    @EnvironmentObject var studyViewModel: StudyViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var selectedStudy: Study?
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
            
            ScrollView {
                VStack {
                    SelectStudyState()
                        .padding(.horizontal, 20)
                    MyStudyList()
                }
                .padding(.top, 10)
                .padding(.bottom, 20)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Text("Mogong")
                        .font(.title2)
                        .fontWeight(.heavy)
                }
            }
        }
        .onAppear {
            self.selectedStudy = studyViewModel.studys[0]
        }
    }
}

struct SelectStudyState: View {
    @EnvironmentObject private var viewModel: StudyViewModel
    @State private var isOngoing: Bool = true
    
    var body: some View {
        HStack {
            StudyStateButton(title: "진행중인 스터디", studyCount: viewModel.studys.filter { !$0.isStudyCompleted }.count, isSelected: isOngoing ? true : false)
                .onTapGesture {
                    withAnimation {
                        isOngoing = true
                        viewModel.myStudyStateIsOngoing = true
                        viewModel.myStudySelectedStudyIndex = 0
                    }
                }
            
            Spacer()
                .frame(width: 10)
            
            StudyStateButton(title: "종료 스터디", studyCount: viewModel.studys.filter { $0.isStudyCompleted }.count, isSelected: isOngoing ? false : true)
                .onTapGesture {
                    withAnimation {
                        isOngoing = false
                        viewModel.myStudyStateIsOngoing = false
                        viewModel.myStudySelectedStudyIndex = 0
                    }
                }
        }
    }
}

struct StudyStateButton: View {
    var title: String
    var studyCount: Int
    
    var isSelected: Bool
    
    var body: some View {
        HStack(spacing: 5) {
            if isSelected {
                Spacer()
                
                Image(systemName: "circle.fill")
                    .resizable()
                    .foregroundColor(.blue)
                    .frame(width: 10, height: 10)
                
                Text(title)
                    .font(Font.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                
                Text("\(studyCount)")
                    .foregroundColor(Color(uiColor: .systemGray5))
                    .font(.pretendard(weight: .semiBold, size: 14))
                
                Spacer()
            } else {
                Text(title)
                    .font(Font.system(size: 16, weight: .medium))
                    .foregroundColor(Color(uiColor: .systemGray5))
                    .padding(.horizontal, 15)
            }
        }
        .padding(.vertical, 8)
        .background(.white)
        .cornerRadius(12)
    }
}

struct MyStudyList: View {
    @EnvironmentObject private var studyViewModel: StudyViewModel
    @EnvironmentObject private var userViewModel: UserViewModel
    
    @State var selectedStudy: Study = StudyViewModel().studys[0]
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(
                            studyViewModel.myStudyStateIsOngoing
                            ? Array(studyViewModel.filterdOngoingMyStudys.enumerated())
                            : Array(studyViewModel.filterdCompletedMyStudys.enumerated())
                            , id: \.element.id
                        ) { index, study in
                            MyStudyListCell(
                                isSelected: studyViewModel.myStudySelectedStudyIndex == index,
                                isHost: isCurrentUserIsHost(study),
                                dDay: study.dueDate
                            )
                            .onTapGesture {
                                withAnimation {
                                    self.studyViewModel.myStudySelectedStudyIndex = index
                                    proxy.scrollTo(index, anchor: .center)
                                    self.selectedStudy = study
                                }
                            }
                            .onAppear {
                                self.selectedStudy = study
                            }
                            .id(index)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            
            MyStudyIntroduction(study: $selectedStudy)
                .padding(.horizontal, 20)
        }
    }
    
    func isCurrentUserIsHost(_ study: Study) -> Bool {
        return study.host.user.id == userViewModel.currentUser.id
    }
}

struct MyStudyListCell: View {
    @EnvironmentObject private var studyViewModel: StudyViewModel
    
    var isSelected: Bool
    var isHost: Bool
    var dDay: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if isHost {
                    Image(systemName: "bookmark.circle.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.orange)
                }
                Spacer()
                Text(isHost ? "내가 방장!" : "나는 팀원!")
            }
            
            Spacer()
            
            Text(studyViewModel.myStudyStateIsOngoing ? "스터디 출발" : "스터디 완주")
                .font(.pretendard(weight: .semiBold, size: 14))
            Text(dDay.dDayString())
                .font(.pretendard(weight: .bold, size: 40))
        }
        .foregroundColor(isSelected ? .white : Color(uiColor: .systemGray4))
        .padding()
        .frame(width: 191, height: 191)
        .background(isSelected ? .blue : Color(uiColor: .systemGray5))
        .cornerRadius(16)
    }
}

struct MyStudyIntroduction: View {
    @EnvironmentObject private var studyViewModel: StudyViewModel
    @EnvironmentObject private var userViewModel: UserViewModel
    @Binding var study: Study
    
    var currentUsrIsHost: Bool {
        return study.host.user.id == userViewModel.currentUser.id
    }
    
    var body: some View {
        VStack(spacing: 30) {
            IntroduceTitle(study: $study)
            
            if currentUsrIsHost {
                NavigationLink {
                    // 방장 - 지원서 확인하기
                } label: {
                    HStack {
                        Text("지원서 확인하기")
                        Spacer()
                        Text(">")
                    }
                    .padding()
                    .font(.pretendard(weight: .bold, size: 20))
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(10)
                }
            } else {
                NavigationLink {
                    // 팀원 - 스터디 완료 기록
                } label: {
                    HStack {
                        Spacer()
                        Text("스터디 완료 기록 적으러 가기")
                        Spacer()
                    }
                    .padding()
                    .font(.pretendard(weight: .bold, size: 20))
                    .foregroundColor(.white)
                    .background(.orange)
                    .cornerRadius(10)
                }
            }
            
            IntroduceMember(study: $study)
        }
    }
}

struct IntroduceTitle: View {
    @EnvironmentObject private var studyViewModel: StudyViewModel
    @EnvironmentObject private var userViewModel: UserViewModel
    @Binding var study: Study
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("스터디 이름")
                    .font(.pretendard(weight: .bold, size: 20))
                Text(study.title)
                    .font(.pretendard(weight: .medium, size: 18))
                    .foregroundColor(.gray)
                    .lineLimit(nil)
            }
            Spacer()
        }
    }
}

struct IntroduceMember: View {
    @EnvironmentObject private var studyViewModel: StudyViewModel
    @EnvironmentObject private var userViewModel: UserViewModel
    @State private var showRemoveSheet: Bool = false
    @Binding var study: Study
    
    var currentUsrIsHost: Bool {
        return study.host.user.id == userViewModel.currentUser.id
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("스터디원")
                    .font(.pretendard(weight: .bold, size: 20))
                Spacer()
                if currentUsrIsHost {
                    Text("내보내기")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .font(.pretendard(weight: .medium, size: 14))
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(15)
                        .onTapGesture {
                            //self.showRemoveSheet = true
                            studyViewModel.myStudyshowRemoveSheet = true
                        }
                }
            }
            
            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 37) {
                ForEach(studyViewModel.studys[studyViewModel.myStudySelectedStudyIndex].currentMembers, id: \.self) { member in
                    NavigationLink {
                        UserPageView()
                    } label: {
                        HStakTeamMemberView(member: member, isSelected: false)
                    }
                }
                
                ForEach(Array(study.requiredCountPerFieldDic()), id: \.key) { field, count in
                    ForEach(0..<count) { _ in
                        HStackNewTeamMemberView(field: field)
                    }
                }
            }
        }
        .sheet(isPresented: $studyViewModel.myStudyshowRemoveSheet) {
            RemoveMemberView()
                .presentationDetents([.fraction(0.8)])
        }
    }
}

struct MyStudyView_Previews: PreviewProvider {
    static var previews: some View {
        MyStudyView()
            .environmentObject(UserViewModel())
            .environmentObject(StudyViewModel())
    }
}

