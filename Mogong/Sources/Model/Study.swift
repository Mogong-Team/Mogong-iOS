//
//  Study2.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/24.
//

import Foundation

enum StudyCategory: String, Codable {
    case all = "전체"
    case generalStudy = "일반형"
    case projectStudy = "프로젝트형"
}

enum StudyLocation: String, Codable {
    case online = "온라인"
    case offline = "오프라인"
    case both = "온/오프라인"
}

enum RevenuePurpose: String, Codable {
    case withRevenue = "있음"
    case withoutRevenue = "없음"
}

enum StudyState: String, Codable {
    case recruiting = "모집중"
    case completed = "모집완료"
    case ended = "스터디종료"
}

struct Study: Identifiable, Codable {
    var id: String = UUID().uuidString
    
    var category: StudyCategory
    var loaction: StudyLocation
    var title: String
    var introduction: String
    var goal: String
    var memberPreference: String
    var dueDate: Date
    
    var frequencyOfWeek: Int
    var durationOfMonth: Int
    var languages: [Language]
    var numberOfRecruits: Int
    
    var positionInfos: [PositionInfo]
    var revenuePurpose: RevenuePurpose?
    
    var host: User
    var currentMembers: [Member2]
    var createDate: Date
    var state: StudyState
    
    var bookMarkedUsers: [User]
}

extension Study {
    static var study1 = Study(
        category: .projectStudy,
        loaction: .online,
        title: "[창업/스타트업] 정부 지원 사업에 합격한 아이템으로 함께 MVP 제작할 개발자 구합니다.(2일 뒤 마감_편하게 연락주세요)",
        introduction: "화이팅",
        goal: "이번달까지 출시가 목표입니다.",
        memberPreference: "아무나 상관없습니다.",
        dueDate: Date(),
        frequencyOfWeek: 2,
        durationOfMonth: 3,
        languages: [.swift, .kotlin],
        numberOfRecruits: 5,
        positionInfos: [
            PositionInfo(position: .backend, requiredCount: 2, language: [.django]),
            PositionInfo(position: .ios, requiredCount: 2, language: [.swift]),
            PositionInfo(position: .designer, requiredCount: 2, language: [.figma]),
        ],
        revenuePurpose: .withRevenue,
        host: User.user1,
        currentMembers: [
            Member2(user: User.user1, position: .backend),
            Member2(user: User.user2, position: .ios),
            Member2(user: User.user3, position: .backend),
            Member2(user: User.user4, position: .designer),
        ],
        createDate: Date(),
        state: .recruiting,
        bookMarkedUsers: [
            User.user2,
            User.user3,
        ])
}

extension StudyViewModel {
    func initStudys() {
        studys = [
            Study.study1,
            
            Study(
                category: .projectStudy,
                loaction: .online,
                title: "포트폴리오용 프로젝트 모집합니다.(2달)",
                introduction: "화이팅",
                goal: "이번달까지 출시가 목표입니다.",
                memberPreference: "아무나 상관없습니다.",
                dueDate: Date(),
                frequencyOfWeek: 2,
                durationOfMonth: 3,
                languages: [.swift, .kotlin],
                numberOfRecruits: 5,
                positionInfos: [
                    PositionInfo(position: .backend, requiredCount: 5, language: [.django]),
                    PositionInfo(position: .ios, requiredCount: 5, language: [.swift]),
                    PositionInfo(position: .designer, requiredCount: 2, language: [.figma]),
                    PositionInfo(position: .planner, requiredCount: 2)
                ],
                revenuePurpose: .withRevenue,
                host: User.user2,
                currentMembers: [
                    Member2(user: User.user1, position: .planner),
                    Member2(user: User.user2, position: .ios),
                ],
                createDate: Date(),
                state: .recruiting,
                bookMarkedUsers: [
                    User.user2,
                    User.user3,
                ]),
            
            Study(
                category: .generalStudy,
                loaction: .online,
                title: "면접 스터디 고고",
                introduction: "화이팅",
                goal: "이번달까지",
                memberPreference: "아무나 상관없습니다.",
                dueDate: Date(),
                frequencyOfWeek: 2,
                durationOfMonth: 3,
                languages: [],
                numberOfRecruits: 5,
                positionInfos: [
                ],
                host: User.user3,
                currentMembers: [
                    Member2(user: User.user3, position: .planner),
                    Member2(user: User.user4, position: .ios),
                ],
                createDate: Date(),
                state: .recruiting,
                bookMarkedUsers: [
                    User.user2,
                    User.user3,
                ]),
        ]
    }
}
