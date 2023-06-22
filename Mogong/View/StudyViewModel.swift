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
        Study(title: "한달동안 프로젝트 같이해요!", frequencyOfWeek: 2, durationOfMonth: 2, studyMode: .online, totalMemberCount: 5, introduction: "안녕하세요", memberPreference: "누구든 상관없어요", hashtags: ["#자바스크립트", "#앱개발", "#디자이너"], dueDate: Date(timeIntervalSinceNow: 24*3600*7), languages: [.javaScript, .figma, .swift], fields: [.backend, .designer], profitGoal: .no, recruitmentType: .teamProject, isBookMarked: true, isCompleted: false),
        Study(title: "한달동안 프로젝트 같이해요!", frequencyOfWeek: 2, durationOfMonth: 2, studyMode: .online, totalMemberCount: 5, introduction: "안녕하세요", memberPreference: "누구든 상관없어요", hashtags: ["#자바스크립트", "#앱개발", "#디자이너"], dueDate: Date(timeIntervalSinceNow: 24*3600*7), languages: [.javaScript, .figma, .swift], fields: [.backend, .designer], profitGoal: .no, recruitmentType: .teamProject, isBookMarked: true, isCompleted: false),
        Study(title: "한달동안 프로젝트 같이해요!", frequencyOfWeek: 2, durationOfMonth: 2, studyMode: .online, totalMemberCount: 5, introduction: "안녕하세요", memberPreference: "누구든 상관없어요", hashtags: ["#자바스크립트", "#앱개발", "#디자이너"], dueDate: Date(timeIntervalSinceNow: 24*3600*7), languages: [.javaScript, .figma, .swift], fields: [.backend, .designer], profitGoal: .no, recruitmentType: .teamProject, isBookMarked: true, isCompleted: false)
    ]

}
