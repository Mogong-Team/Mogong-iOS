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
        VStack {
            SelectState()
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 5)
            
            ScrollView(showsIndicators: false) {
                VStack {
                    MyStudyList()
                }
                .padding(.top, 10)
                .padding(.bottom, 20)
            }
            .onAppear {
                studyViewModel.selectedMyStudyStateIsEnded = false
                studyViewModel.selectedMyStudyIndex = 0
                // TODO: Get Study
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Image("nav_mogongLogo")
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                NavigationLink {
                    ChatListView()
                } label: {
                    Image(systemName: "paperplane")
                        .tint(.black)
                }
                
                NavigationLink {
                    AlarmView()
                } label: {
                    Image(systemName: "bell")
                        .tint(.black)
                }
            }
        }
    }
}

struct SelectState: View {
    @EnvironmentObject private var studyViewModel: StudyViewModel
    
    var body: some View {
        HStack(spacing: 10) {
            SelectStateButton(
                title: "진행중인 스터디",
                studyCount: studyViewModel.studys.filter { $0.state != .ended }.count,
                isSelected: studyViewModel.selectedMyStudyStateIsEnded ? false : true
            )
            .onTapGesture {
                withAnimation {
                    studyViewModel.selectedMyStudyStateIsEnded = false
                    studyViewModel.selectedMyStudyIndex = 0
                }
            }
            
            SelectStateButton(
                title: "종료 스터디",
                studyCount: studyViewModel.studys.filter { $0.state == .ended }.count,
                isSelected: studyViewModel.selectedMyStudyStateIsEnded ? true : false
            )
            .onTapGesture {
                withAnimation {
                    studyViewModel.selectedMyStudyStateIsEnded = true
                    studyViewModel.selectedMyStudyIndex = 0
                }
            }
        }
    }
}

struct SelectStateButton: View {
    var title: String
    var studyCount: Int
    var isSelected: Bool
    
    var body: some View {
        HStack(spacing: 5) {
            if isSelected {
                Spacer()
                Image(systemName: "circle.fill")
                    .resizable()
                    .foregroundColor(Color(hexColor: "0090FF"))
                    .frame(width: 10, height: 10)
                Text(title)
                    .font(.pretendard(weight: .bold, size: 16))
                    .foregroundColor(.black)
                Text("\(studyCount)")
                    .foregroundColor(Color(hexColor: "D9D9D9"))
                    .font(.pretendard(weight: .semiBold, size: 14))
                Spacer()
            } else {
                Text(title)
                    .font(.pretendard(weight: .medium, size: 16))
                    .foregroundColor(Color(hexColor: "CACACA"))
                    .padding(.horizontal, 15)
            }
        }
        .padding(.vertical, 8)
        .background(.white)
        .cornerRadius(12)
        .shadow(color: Color(white: 0, opacity: 0.1), radius: 5, x: 0, y: 0)
    }
}

struct MyStudyList: View {
    @EnvironmentObject private var studyViewModel: StudyViewModel
    @EnvironmentObject private var userViewModel: UserViewModel
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(
                            studyViewModel.selectedMyStudyStateIsEnded
                            ? Array(studyViewModel.filterdEndedMyStudy.enumerated())
                            : Array(studyViewModel.filterdOngoingMyStudy.enumerated())
                            , id: \.element.id
                        ) { index, study in
                            MyStudyListCell(
                                isHost: userViewModel.currentUserIsHost(study: study),
                                dDay: study.dueDate,
                                isSelected: studyViewModel.selectedMyStudyIndex == index,
                                isOngoing: !studyViewModel.selectedMyStudyStateIsEnded
                            )
                            .onTapGesture {
                                studyViewModel.selectedMyStudyIndex = index
                                studyViewModel.selectedStudy = study
                            }
                            .id(index) // ScrollViewReader -> 없으면 scrollTo 활성화 안됨.
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 15)
                }
                .onChange(of: studyViewModel.selectedMyStudyIndex) { newIndex in
                    withAnimation {
                        proxy.scrollTo(newIndex, anchor: .center)
                    }
                }
            }
            
            if studyViewModel.selectedMyStudyStateIsEnded && studyViewModel.filterdEndedMyStudy.isEmpty {
                MyStudyEmptyView()
            } else if !studyViewModel.selectedMyStudyStateIsEnded && studyViewModel.filterdOngoingMyStudy.isEmpty {
                MyStudyEmptyView()
            } else {
                MyStudyIntroduce()
                    .padding(.horizontal, 20)
            }
        }
        .onChange(of: studyViewModel.selectedMyStudyStateIsEnded) { _ in
            if studyViewModel.selectedMyStudyStateIsEnded {
                guard let firstStudy = studyViewModel.filterdEndedMyStudy.first else { return }
                studyViewModel.selectedStudy = firstStudy
            } else {
                guard let firstStudy = studyViewModel.filterdEndedMyStudy.first else { return }
                studyViewModel.selectedStudy = firstStudy
            }
        }
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
                        .foregroundColor(Color(hexColor: "FFA215"))
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
        .foregroundColor(isSelected
                         ? .white
                         : Color(hexColor: "C5C5C5"))
        .padding()
        .frame(width: 191, height: 191)
        .background(isSelected
                    ? Color.main
                    : Color(hexColor: "EAEDF4"))
        .cornerRadius(16)
    }
}

struct MyStudyIntroduce: View {
    @EnvironmentObject private var studyViewModel: StudyViewModel
    @EnvironmentObject private var userViewModel: UserViewModel

    var body: some View {
        VStack(spacing: 20) {
            NavigationLink {
                // TODO: 출석 체크
            } label: {
                Text("스터디 출석체크")
                .font(.pretendard(weight: .bold, size: 20))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(Color(hexColor: "FFA215"))
                .cornerRadius(30)
            }
            IntroduceTitle()
            if userViewModel.currentUserIsHost(study: studyViewModel.selectedStudy) {
                NavigationLink {
                    ApplicationListView(user: userViewModel.currentUser)
                } label: {
                    HStack {
                        Text("지원자 리스트")
                        Spacer()
                        Text(">")
                    }
                    .padding()
                    .font(.pretendard(weight: .bold, size: 20))
                    .foregroundColor(.white)
                    .background(Color.main)
                    .cornerRadius(30)
                }
            }
            IntroduceMember()
        }
    }
}

struct IntroduceTitle: View {
    @EnvironmentObject private var studyViewModel: StudyViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                Text("스터디 이름")
                    .font(.pretendard(weight: .bold, size: 20))
                Text(studyViewModel.selectedStudy.title)
                    .font(.pretendard(weight: .medium, size: 18))
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                    .lineSpacing(3)
            }
            Spacer()
        }
    }
}

struct IntroduceMember: View {
    @EnvironmentObject private var studyViewModel: StudyViewModel
    @EnvironmentObject private var userViewModel: UserViewModel
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Text("스터디원")
                    .font(.pretendard(weight: .bold, size: 20))
                Spacer()
                if userViewModel.currentUserIsHost(study: studyViewModel.selectedStudy) {
                    Text("내보내기")
                        .font(.pretendard(weight: .medium, size: 14))
                        .foregroundColor(.white)
                        .frame(width: 67, height: 25)
                        .background(Color(hexColor: "91B9F2"))
                        .cornerRadius(15)
                        .onTapGesture {
                            studyViewModel.showRemoveMember = true
                        }
                }
            }
            
            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 37) {
                ForEach(studyViewModel.selectedStudy.currentMembers, id: \.self) { member in
                    NavigationLink {
                        UserPageView()
                    } label: {
                        HStakTeamMemberView(
                            member: member,
                            isSelected: false,
                            isHost: studyViewModel.isHostUser(study: studyViewModel.selectedStudy, member: member)
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
        .sheet(isPresented: $studyViewModel.showRemoveMember) {
            RemoveMemberView()
                .presentationDetents([.fraction(0.7)])
        }
    }
}

struct MyStudyEmptyView: View {
    @EnvironmentObject private var studyViewModel: StudyViewModel

    var body: some View {
        VStack {
            Spacer()
                .frame(height: 250)
            Text(studyViewModel.selectedMyStudyStateIsEnded
                 ? "종료된 스터디가 없습니다."
                 : "진행중인 스터디가 없습니다.")
            .font(.pretendard(weight: .semiBold, size: 18))
        }
    }
}

struct MyStudyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MyStudyView()
                .environmentObject(UserViewModel())
                .environmentObject(StudyViewModel())
        }
    }
}

