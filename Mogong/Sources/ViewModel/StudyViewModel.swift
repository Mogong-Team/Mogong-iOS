//
//  StudyViewModel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI
import Combine

class StudyViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    
    var study =
    Study(id: "10", title: "한달동안 프로젝트 같이해요!", frequencyOfWeek: 2, durationOfMonth: 2,
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
    
    var studys = [
        Study(id: "1", title: "스터디1 함께해요.", frequencyOfWeek: 2, durationOfMonth: 2,
              studyType: .teamProject, studyMode: .online, totalMemberCount: 5,
              requiredPositions: [
                Position(field: .backend, requiredFieldCount: 2),
                Position(field: .frontend, requiredFieldCount: 1),
                Position(field: .designer, requiredFieldCount: 1),
                Position(field: .ios, requiredFieldCount: 1)
              ],
              host:
                Member(user: User(id: "1", name: "김민수", email: "a@gmail.com", username: "민수민수"), field: .backend),
              currentMember: [
                Member(user: User(id: "1", name: "김민수", email: "a@gmail.com", username: "민수민수"), field: .backend),
                Member(user: User(id: "2", name: "김종민", email: "a@gmail.com", username: "종민종민"), field: .frontend),
                Member(user: User(id: "3", name: "김정수", email: "a@gmail.com", username: "정수정수"),  field: .ios),
                Member(user: User(id: "4", name: "김나연", email: "a@gmail.com", username: "나연나연"),  field: .designer),
              ],
              introduction: "안녕하세요", memberPreference: "누구든 상관없어요", hashtags: ["#자바스크립트", "#앱개발", "#디자이너"],
              createDate: Date(), dueDate: Date(timeIntervalSinceNow: 24*3600*7), languages: [.javaScript, .figma, .swift],
              fields: [.backend, .designer], profitGoal: .no,
              isBookMarked: true, bookMarkCount: 5, isRecruitmentCompleted: false, isStudyCompleted: false),
        
        Study(id: "2", title: "스터디2 함께해요.", frequencyOfWeek: 2, durationOfMonth: 2,
              studyType: .teamProject, studyMode: .online, totalMemberCount: 5,
              requiredPositions: [
                Position(field: .backend, requiredFieldCount: 2),
                Position(field: .frontend, requiredFieldCount: 1),
                Position(field: .designer, requiredFieldCount: 1),
                Position(field: .ios, requiredFieldCount: 1)
              ],
              host:
                Member(user: User(id: "2", name: "김종민", email: "a@gmail.com", username: "종민종민"), field: .frontend),
              currentMember: [
                Member(user: User(id: "1", name: "김민수", email: "a@gmail.com", username: "민수민수"), field: .backend),
                Member(user: User(id: "2", name: "김종민", email: "a@gmail.com", username: "종민종민"), field: .frontend),
                Member(user: User(id: "3", name: "김정수", email: "a@gmail.com", username: "정수정수"),  field: .ios),
                Member(user: User(id: "4", name: "김나연", email: "a@gmail.com", username: "나연나연"),  field: .designer),
              ],
              introduction: "안녕하세요", memberPreference: "누구든 상관없어요", hashtags: ["#자바스크립트", "#앱개발", "#디자이너"],
              createDate: Date(), dueDate: Date(timeIntervalSinceNow: 24*3600*7), languages: [.javaScript, .figma, .swift],
              fields: [.backend, .designer], profitGoal: .no,
              isBookMarked: true, bookMarkCount: 5, isRecruitmentCompleted: false, isStudyCompleted: false),
        
        Study(id: "3", title: "스터디3 함께해요.", frequencyOfWeek: 2, durationOfMonth: 2,
              studyType: .teamProject, studyMode: .online, totalMemberCount: 5,
              requiredPositions: [
                Position(field: .backend, requiredFieldCount: 2),
                Position(field: .frontend, requiredFieldCount: 1),
                Position(field: .designer, requiredFieldCount: 1),
                Position(field: .ios, requiredFieldCount: 1)
              ],
              host:
                Member(user: User(id: "4", name: "김나연", email: "a@gmail.com", username: "나연나연"),  field: .designer),
              currentMember: [
                Member(user: User(id: "1", name: "김민수", email: "a@gmail.com", username: "민수민수"), field: .backend),
                Member(user: User(id: "2", name: "김종민", email: "a@gmail.com", username: "종민종민"), field: .frontend),
                Member(user: User(id: "3", name: "김정수", email: "a@gmail.com", username: "정수정수"),  field: .ios),
                Member(user: User(id: "4", name: "김나연", email: "a@gmail.com", username: "나연나연"),  field: .designer),
              ],
              introduction: "안녕하세요", memberPreference: "누구든 상관없어요", hashtags: ["#자바스크립트", "#앱개발", "#디자이너"],
              createDate: Date(), dueDate: Date(timeIntervalSinceNow: 24*3600*7), languages: [.javaScript, .figma, .swift],
              fields: [.backend, .designer], profitGoal: .no,
              isBookMarked: true, bookMarkCount: 5, isRecruitmentCompleted: false, isStudyCompleted: true)
    ]
}

