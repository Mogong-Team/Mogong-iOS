//
//  MyStudyView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/21.
//

import SwiftUI

/*
 - ongoing: 진행중
 - completed: 종료
 */
enum MyStudyType {
    case ongoing
    case completed
}

enum MyStudyMember {
    case leader
    case member
}

struct MyStudyView: View {
    @EnvironmentObject var viewModel: StudyViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var type: MyStudyType = .ongoing
    @State private var selectedButton: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                SelectButton(title: "가입한 스터디", state: selectedButton == 0 ? .selected : .unselected) {
                    type = .ongoing
                    selectedButton = 0
                }
                
                SelectButton(title: "종료된 스터디", state: selectedButton == 1 ? .selected : .unselected) {
                    type = .completed
                    selectedButton = 1
                }
            }
            
            ScrollView(.horizontal) {
                HStack {
                    
                    Text("HHH")
                    
                }
            }
            .frame(height: 250)
            .border(Color.red)

            
            ScrollView {
                VStack {
                    ForEach(viewModel.studys.filter { type ==  .ongoing ? !$0.isStudyCompleted : $0.isStudyCompleted }, id: \.self) { study in
                        NavigationLink {
                            MyStudyDetailView(study: viewModel.study, viewType: study.host.user.id == userViewModel.currentUser.id ? .host : .member)
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 33)
                                    .frame(height: 300)
                                    .foregroundColor(Color(uiColor: .systemGray6))
                                
                                if type == .ongoing {
                                    MyStudyCell(study: study, isHostIsCurrentUser: study.host.user.id == userViewModel.currentUser.id ? true : false)
                                } else {
                                    MyStudyCell(study: study, isHostIsCurrentUser: study.host.user.id == userViewModel.currentUser.id ? true : false)
                                }
                            }
                        }
                    }
                }
                .padding(.vertical, 10)
            }
        }
        .padding(.horizontal, 20)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Text("Mogong")
                    .font(.title2)
                    .fontWeight(.heavy)
            }
        }
    }
}

struct MyStudyCell: View {
    var study: Study
    
    var isHostIsCurrentUser: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            if isHostIsCurrentUser {
                Image(systemName: "crown.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.yellow)
            }
            
            Spacer()
            
            Text(study.title)
                .font(.pretendard(weight: .bold, size: 26))
            
            Divider()
            
            CheckLabel(text: study.studyMode.rawValue)
            CheckLabel(text: "참여인원 \(study.totalMemberCount)명 / 주 \(study.frequencyOfWeek)회(\(study.durationOfMonth)개월) 진행")
        }
        .padding(20)
    }
}

struct MyStudyView_Previews: PreviewProvider {
    static var previews: some View {
        MyStudyView()
            .environmentObject(UserViewModel())
            .environmentObject(StudyViewModel())
    }
}

