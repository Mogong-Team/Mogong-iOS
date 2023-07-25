//
//  BookmarkCellView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/03.
//

import SwiftUI

struct BookmarkCellView: View {
    var study: Study
    
    var body: some View {
        VStack {
            HStack {
                Text(study.isRecruitmentCompleted ? "모집완료" : "모집중")
                    .font(.pretendard(weight: .bold, size: 12))
                    .foregroundColor(.white)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 3)
                    .background(study.isRecruitmentCompleted ? Color.gray : Color.yellow)
                    .cornerRadius(5)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: study.isRecruitmentCompleted ? "bookmark" : "bookmark.fill")
                        .foregroundColor(study.isRecruitmentCompleted ? Color.black : Color.yellow)
                }
            }
            
            HStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                    .clipShape(Circle())
                
                VStack {
                    Text(study.title)
                        .font(.pretendard(weight: .bold, size: 13))
                }
                
                Spacer()
            }
            
            HStack {
                VStack {
                    CheckLabel(text: "111", isHighlighted: false)
                    CheckLabel(text: "111", isHighlighted: false)
                }
                
                Spacer()
            }
        }
    }
}

struct BookmarkCellView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkCellView(study: Study(id: "10", title: "[창업/스타트업] 정부 지원 사업에 합격한 아이템으로 함께 MVP 제작할 개발자 구합니다.(2일 뒤 마감_편하게 연락주세요)", frequencyOfWeek: 2, durationOfMonth: 2,
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
                                      isBookMarked: true, bookMarkCount: 5, isRecruitmentCompleted: false, isStudyCompleted: false))
    }
}

