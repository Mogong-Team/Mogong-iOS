//
//  StudyDeatailView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/26.
//

import SwiftUI

struct StudyDeatailView: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    @State private var study = Study(id: "1", title: "한달동안 프로젝트 같이해요!", frequencyOfWeek: 2, durationOfMonth: 2, studyType: .teamProject, studyMode: .online, totalMemberCount: 5, host: User(id: "1", name: "김방장", email: "a@gmail.com", username: "나방장"), currentMember: [
        User(id: "1", name: "김방장", email: "a@gmail.com", username: "나방장"),
        User(id: "2", name: "박민수", email: "a@gmail.com", username: "박민수"),
        User(id: "3", name: "최민수", email: "a@gmail.com", username: "최민수")
    ], introduction: "안녕하세요", memberPreference: "누구든 상관없어요", hashtags: ["#자바스크립트", "#앱개발", "#디자이너"], createDate: Date(), dueDate: Date(timeIntervalSinceNow: 24*3600*7), languages: [.javaScript, .figma, .swift], fields: [.backend, .designer], profitGoal: .no, isBookMarked: true, isCompleted: false, bookMarkCount: 5)
    
    @Environment(\.dismiss) var dismiss
    @State private var isComplete: Bool = false
    
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 50, height: 20)
                                .foregroundColor(.gray)
                            
                            Label("\(study.bookMarkCount)", systemImage: "bookmark.fill")
                                .font(Font.system(size: 12))
                        }
                        
                        Text(study.title)
                            .font(Font.system(size: 36, weight: .bold))
                            .multilineTextAlignment(.leading)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            HStack(spacing: 5) {
                                Text("모집 형태")
                                    .font(Font.system(size: 15, weight: .bold))
                                    .foregroundColor(.gray)
                                
                                Text(study.studyType.rawValue)
                                    .font(Font.system(size: 15, weight: .bold))
                            }
                            
                            HStack(spacing: 5) {
                                Text("모집 인원")
                                    .font(Font.system(size: 15, weight: .bold))
                                    .foregroundColor(.gray)
                                
                                Text("\(study.currentMember.count) / \(study.totalMemberCount)")
                                    .font(Font.system(size: 15, weight: .bold))
                            }
                            
                            HStack(spacing: 5) {
                                Text("스터디 방식")
                                    .font(Font.system(size: 15, weight: .bold))
                                    .foregroundColor(.gray)
                                
                                Text(study.studyMode.rawValue)
                                    .font(Font.system(size: 15, weight: .bold))
                            }
                            
                            HStack(spacing: 5) {
                                Text("예상 기간")
                                    .font(Font.system(size: 15, weight: .bold))
                                    .foregroundColor(.gray)
                                
                                Text("\(study.durationOfMonth)달")
                                    .font(Font.system(size: 15, weight: .bold))
                            }
                            
                            HStack(spacing: 5) {
                                Text("사용 언어")
                                    .font(Font.system(size: 15, weight: .bold))
                                    .foregroundColor(.gray)
                                
                                LazyHGrid(rows: [GridItem()]) {
                                    ForEach(study.languages, id: \.self) { language in
                                        HashtagView(text: language.rawValue)
                                    }
                                }
                            }
                            
                            HStack(spacing: 5) {
                                Text("모집 분야")
                                    .font(Font.system(size: 15, weight: .bold))
                                    .foregroundColor(.gray)
                                
                                LazyHGrid(rows: [GridItem()]) {
                                    ForEach(study.fields, id: \.self) { field in
                                        HashtagView(text: field.rawValue)
                                    }
                                }
                            }
                            
                            HStack(spacing: 5) {
                                Text("수익화 목적")
                                    .font(Font.system(size: 15, weight: .bold))
                                    .foregroundColor(.gray)
                                
                                Text(study.profitGoal.rawValue)
                                    .font(Font.system(size: 15, weight: .bold))
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("프로젝트 소개")
                            .font(Font.system(size: 24, weight: .bold))
                        
                        Text(study.introduction)
                    }
                    .padding(20)
                    
                    Spacer()
                }
                .background(Color(uiColor: .systemGray5))
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("참여중인 인원")
                            .font(Font.system(size: 24, weight: .bold))
                        
                        LazyVGrid(columns: [GridItem(), GridItem()], alignment: .center, spacing: nil) {
                            ForEach(study.currentMember) { member in
                                MemberIntroductionView(username: member.username)
                            }
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("이런 분을 모셔요!")
                            .font(Font.system(size: 24, weight: .bold))
                        
                        Text(study.memberPreference)
                    }
                    
                    VStack {
                        SelectButton(title: "이 프로젝트 지원하기", state: .selected) {
                            isComplete = true
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding(.vertical, 10)
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .tint(.black)
                }
            }
        }
        .navigationDestination(isPresented: $isComplete) {
            // next page
        }
    }
}

struct StudyDeatailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            StudyDeatailView()
        }
    }
}

