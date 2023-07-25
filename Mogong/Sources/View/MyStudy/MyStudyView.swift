//
//  MyStudyView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/21.
//

import SwiftUI

struct MyStudyView: View {
    @EnvironmentObject var studyViewModel: StudyViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
            NavigationView {
                VStack {
                    TopBarView()
                    
                    ZStack {
                        Color(uiColor: .systemGray6)
                        
                        ScrollView(showsIndicators: false) {
                            VStack {
                                MyStudyStateSelect()
                                    .padding(.horizontal, 20)
                                MyStudyList()
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                        }
                    }
                    .onAppear {
                        studyViewModel.myStudyStateIsOngoing = true
                        studyViewModel.myStudySelectedStudyIndex = 0
                    }
                    
                    TabBarView()
                }
            }
        }
    }

struct MyStudyStateSelect: View {
    @EnvironmentObject private var studyViewModel: StudyViewModel
    
    var body: some View {
        HStack {
            StudyStateButton(
                title: "진행중인 스터디",
                studyCount: studyViewModel.studys.filter { $0.state != .ended }.count,
                isSelected: studyViewModel.myStudyStateIsOngoing ? true : false
            )
            .onTapGesture {
                withAnimation {
                    studyViewModel.myStudyStateIsOngoing = true
                    studyViewModel.myStudySelectedStudyIndex = 0
                }
            }
            
            Spacer()
                .frame(width: 10)
            
            StudyStateButton(
                title: "종료 스터디",
                studyCount: studyViewModel.studys.filter { $0.state == .ended }.count,
                isSelected: studyViewModel.myStudyStateIsOngoing ? false : true
            )
            .onTapGesture {
                withAnimation {
                    studyViewModel.myStudyStateIsOngoing = false
                    studyViewModel.myStudySelectedStudyIndex = 0
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
    
    @State var selectedStudy: Study = StudyViewModel().myStudyFilterdOngoingStudy[0]
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(
                            studyViewModel.myStudyStateIsOngoing
                            ? Array(studyViewModel.myStudyFilterdOngoingStudy.enumerated())
                            : Array(studyViewModel.myStudyFilterdCompletedStudy.enumerated())
                            , id: \.element.id
                        )
                        { index, study in
                            MyStudyListCell(
                                isHost: currentUserIsHost(study),
                                dDay: study.dueDate,
                                isSelected: studyViewModel.myStudySelectedStudyIndex == index,
                                isOngoing: studyViewModel.myStudyStateIsOngoing
                            )
                            .onTapGesture {
                                self.studyViewModel.myStudySelectedStudyIndex = index
                            }
                            .id(index) // ScrollViewReader -> 없으면 scrollTo 활성화 안됨.
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .onChange(of: studyViewModel.myStudySelectedStudyIndex)
                { newIndex in
                    self.selectedStudy =
                    studyViewModel.myStudyStateIsOngoing
                    ? studyViewModel.myStudyFilterdOngoingStudy[newIndex]
                    : studyViewModel.myStudyFilterdCompletedStudy[newIndex]
                    
                    withAnimation {
                        proxy.scrollTo(newIndex, anchor: .center)
                    }
                }
            }
            
            MyStudyIntroduce(study: $selectedStudy)
                .padding(.horizontal, 20)
        }
        .onChange(of: studyViewModel.myStudyStateIsOngoing) { isOngoing in
            self.selectedStudy =
            isOngoing
            ? studyViewModel.myStudyFilterdOngoingStudy[0]
            : studyViewModel.myStudyFilterdCompletedStudy[0]
        }
    }
    
    func currentUserIsHost(_ study: Study) -> Bool {
        return study.host.id == userViewModel.currentUser.id
    }
}

struct MyStudyListCell: View {
    var isHost: Bool
    var dDay: Date
    var isSelected: Bool
    var isOngoing: Bool
    
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
            
            Text(isOngoing ? "스터디 출발" : "스터디 완주")
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

struct MyStudyIntroduce: View {
    @EnvironmentObject private var studyViewModel: StudyViewModel
    @EnvironmentObject private var userViewModel: UserViewModel
    @Binding var study: Study

    var body: some View {
        VStack(spacing: 30) {
            IntroduceTitle(study: $study)
            
            if userViewModel.currentUserIsHost(study: study) {
                NavigationLink {
                    ApplicationListView(user: userViewModel.currentUser)
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
                        Text("스터디 출석체크")
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
    @Binding var study: Study
    
    var body: some View {
        VStack {
            HStack {
                Text("스터디원")
                    .font(.pretendard(weight: .bold, size: 20))
                Spacer()
                if userViewModel.currentUserIsHost(study: study) {
                    Text("내보내기")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .font(.pretendard(weight: .medium, size: 14))
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(15)
                        .onTapGesture {
                            studyViewModel.myStudyshowRemoveSheet = true
                        }
                }
            }
            
            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 37) {
                ForEach(study.currentMembers, id: \.self) { member in
                    NavigationLink {
                        UserPageView()
                    } label: {
                        HStakTeamMemberView(
                            member: member,
                            isSelected: false,
                            isHost: studyViewModel.isHostUser(study: study, member: member)
                        )
                    }
                }
                
//                ForEach(Array(study.requiredCountPerFieldDic()), id: \.key) { field, count in
//                    ForEach(0..<count) { _ in
//                        HStackNewTeamMemberView(field: field)
//                    }
//                }
            }
        }
        .sheet(isPresented: $studyViewModel.myStudyshowRemoveSheet) {
            RemoveMemberView(study: $study)
                .presentationDetents([.fraction(0.7)])
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

