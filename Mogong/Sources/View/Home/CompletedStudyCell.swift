//
//  CompletedStudyCell.swift
//  Mogong
//
//  Created by 예강이다 on 2023/07/08.
//

import SwiftUI

struct CompletedStudyCell: View {
    var study: Study2
    
    var body: some View {
        NavigationLink {
            StudyListView()
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .bottom) {
                    ZStack {
                        Image(systemName: "pencil")
                            .resizable()
                        
                        VStack() {
                            Spacer()
                            Text(study.title)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .lineLimit(3)
                                .padding(10)
                        }
                    }
                }
            }
            .frame(width: 130, height: 185, alignment: .leading)
            .background(Color(uiColor: .white))
            .cornerRadius(15)
            .shadow(color: .gray, radius: 5, x: 2, y: 2)
        }
    }
}

struct CompletedStudyCell_Previews: PreviewProvider {
    static var previews: some View {
        CompletedStudyCell(study:
                            Study2(id: "10", title: "[창업/스타트업] 정부 지원 사업에 합격한 아이템으로 함께 MVP 제작할 개발자 구합니다.(2일 뒤 마감_편하게 연락주세요)", frequencyOfWeek: 2, durationOfMonth: 2,
                                  studyType: .teamProject, studyMode: .online, totalMemberCount: 5,
                                  requiredPositions: [
                                    Position(field: .backend, requiredFieldCount: 2),
                                    Position(field: .frontend, requiredFieldCount: 1),
                                    Position(field: .designer, requiredFieldCount: 3),
                                    Position(field: .ios, requiredFieldCount: 1)
                                  ],
                                  host:
                                    Member(user: User(id: "1", name: "김민수", email: "a@gmail.com", username: "민수민수"), field: .backend),
                                  currentMember: [
                                    Member(user: User(id: "1", name: "김민수", email: "a@gmail.com", username: "민수민수"), field: .backend),
                                    Member(user: User(id: "2", name: "김종민", email: "a@gmail.com", username: "종민종민"), field: .frontend),
                                    Member(user: User(id: "3", name: "김정수", email: "a@gmail.com", username: "정수정수"),  field: .ios),
                                    Member(user: User(id: "3", name: "김나연", email: "a@gmail.com", username: "나연나연"),  field: .designer),
                                  ],
                                  introduction: "안녕하세요", memberPreference: "누구든 상관없어요", hashtags: ["#자바스크립트", "#앱개발", "#디자이너"],
                                  createDate: Date(), dueDate: Date(timeIntervalSinceNow: 24*3600*7), languages: [.javaScript, .figma, .swift],
                                  fields: [.backend, .designer], profitGoal: .no,
                                  isBookMarked: true, bookMarkCount: 5, isRecruitmentCompleted: false, isStudyCompleted: false)
        )
    }
}
