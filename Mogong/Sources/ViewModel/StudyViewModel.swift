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
    
    var studys = [
        Study(title: "한달동안 프로젝트 같이해요!", frequencyOfWeek: 2, durationOfMonth: 2, studyType: .teamProject,studyMode: .online, totalMemberCount: 5, host: User(id: "1", name: "김방장", email: "a@gmail.com", username: "나방장"), introduction: "안녕하세요", memberPreference: "누구든 상관없어요", hashtags: ["#자바스크립트", "#앱개발", "#디자이너"], dueDate: Date(timeIntervalSinceNow: 24*3600*7), languages: [.javaScript, .figma, .swift], fields: [.backend, .designer], profitGoal: .no, isBookMarked: true, isRecruitmentCompleted: false),
        Study(title: "한달동안 프로젝트 같이해요!", frequencyOfWeek: 2, durationOfMonth: 2, studyType: .teamProject,studyMode: .online, totalMemberCount: 5, host: User(id: "1", name: "김방장", email: "a@gmail.com", username: "나방장"), introduction: "안녕하세요", memberPreference: "누구든 상관없어요", hashtags: ["#자바스크립트", "#앱개발", "#디자이너"], dueDate: Date(timeIntervalSinceNow: 24*3600*7), languages: [.javaScript, .figma, .swift], fields: [.backend, .designer], profitGoal: .no, isBookMarked: true, isRecruitmentCompleted: false),
        Study(title: "한달동안 프로젝트 같이해요!", frequencyOfWeek: 2, durationOfMonth: 2, studyType: .teamProject,studyMode: .online, totalMemberCount: 5, host: User(id: "1", name: "김방장", email: "a@gmail.com", username: "나방장"), introduction: "안녕하세요", memberPreference: "누구든 상관없어요", hashtags: ["#자바스크립트", "#앱개발", "#디자이너"], dueDate: Date(timeIntervalSinceNow: 24*3600*7), languages: [.javaScript, .figma, .swift], fields: [.backend, .designer], profitGoal: .no, isBookMarked: true, isRecruitmentCompleted: false),
    ]

    var study = Study(id: "1", title: "한달동안 프로젝트 같이해요!", frequencyOfWeek: 2, durationOfMonth: 2, studyType: .teamProject, studyMode: .online, totalMemberCount: 5, host: User(id: "1", name: "김방장", email: "a@gmail.com", username: "나방장"), currentMember: [
        User(id: "1", name: "김방장", email: "a@gmail.com", username: "나방장"),
        User(id: "2", name: "박민수", email: "a@gmail.com", username: "박민수"),
        User(id: "3", name: "최민수", email: "a@gmail.com", username: "최민수")
    ], introduction: "안녕하세요", memberPreference: "누구든 상관없어요", hashtags: ["#자바스크립트", "#앱개발", "#디자이너"], createDate: Date(), dueDate: Date(timeIntervalSinceNow: 24*3600*7), languages: [.javaScript, .figma, .swift], fields: [.backend, .designer], profitGoal: .no, isBookMarked: true, isRecruitmentCompleted: false, bookMarkCount: 5)
}

