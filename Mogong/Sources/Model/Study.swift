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
    var currentMembers: [Member]
    var createDate: Date = Date()
    var state: StudyState = .recruiting
    
    var bookMarkedUsers: [String] = []
    var submittedApplications: [String] = []
}

extension Study {
    static var study1 = Study(
        category: .projectStudy,
        loaction: .online,
        title: "Study1",
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
            Member(user: User.user1, position: .backend),
            Member(user: User.user2, position: .ios),
            Member(user: User.user3, position: .backend),
            Member(user: User.user4, position: .designer),
        ],
        createDate: Date(),
        state: .recruiting,
        bookMarkedUsers: [],
        submittedApplications: []
    )
    
    static var study2 = Study(
        category: .projectStudy,
        loaction: .online,
        title: "study2",
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
        host: User.user2,
        currentMembers: [
            Member(user: User.user2, position: .ios),
        ],
        createDate: Date(),
        state: .completed,
        bookMarkedUsers: [],
        submittedApplications: []
    )
    
    static var study3 = Study(
        category: .generalStudy,
        loaction: .online,
        title: "study3",
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
        host: User.user3,
        currentMembers: [
            Member(user: User.user3, position: .backend),
        ],
        createDate: Date(),
        state: .recruiting,
        bookMarkedUsers: [],
        submittedApplications: []
    )
    
    static var study4 = Study(
        category: .projectStudy,
        loaction: .online,
        title: "study4",
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
        host: User.user4,
        currentMembers: [
            Member(user: User.user4, position: .designer),
        ],
        createDate: Date(),
        state: .completed,
        bookMarkedUsers: [],
        submittedApplications: []
    )
}

//extension StudyViewModel {
//    func initStudys() {
//        studys = [
//            Study.study1,
//
//            Study(
//                category: .projectStudy,
//                loaction: .online,
//                title: "포트폴리오용 프로젝트 모집합니다.(2달)",
//                introduction: "화이팅",
//                goal: "이번달까지 출시가 목표입니다.",
//                memberPreference: "아무나 상관없습니다.",
//                dueDate: Date(),
//                frequencyOfWeek: 2,
//                durationOfMonth: 3,
//                languages: [.swift, .kotlin],
//                numberOfRecruits: 5,
//                positionInfos: [
//                    PositionInfo(position: .backend, requiredCount: 5, language: [.django]),
//                    PositionInfo(position: .ios, requiredCount: 5, language: [.swift]),
//                    PositionInfo(position: .designer, requiredCount: 2, language: [.figma]),
//                    PositionInfo(position: .planner, requiredCount: 2)
//                ],
//                revenuePurpose: .withRevenue,
//                host: User.user2,
//                currentMembers: [
//                    Member(user: User.user1, position: .planner),
//                    Member(user: User.user2, position: .ios),
//                ],
//                createDate: Date(),
//                state: .recruiting,
//                bookMarkedUsers: [
//                    User.user2,
//                    User.user3,
//                ]),
//
//            Study(
//                category: .generalStudy,
//                loaction: .online,
//                title: "면접 스터디 고고",
//                introduction: "화이팅",
//                goal: "이번달까지",
//                memberPreference: "아무나 상관없습니다.",
//                dueDate: Date(),
//                frequencyOfWeek: 2,
//                durationOfMonth: 3,
//                languages: [],
//                numberOfRecruits: 5,
//                positionInfos: [
//                ],
//                host: User.user3,
//                currentMembers: [
//                    Member(user: User.user3, position: .planner),
//                    Member(user: User.user4, position: .ios),
//                ],
//                createDate: Date(),
//                state: .recruiting,
//                bookMarkedUsers: [
//                    User.user2,
//                    User.user3,
//                ]),
//        ]
//    }
//}

//mutating func addMember(_ member: Member) {
//    if let index = requiredPositions.firstIndex(where: { $0.field == member.field }) {
//        requiredPositions[index].currentCount += 1
//    }
//
//    currentMembers.append(member)
//}
//
//mutating func removeMember(_ member: Member) {
//    if let index = requiredPositions.firstIndex(where: { $0.field == member.field }) {
//        requiredPositions[index].currentCount -= 1
//    }
//
//    if let index = currentMembers.firstIndex(where: { $0.user.id == member.user.id }) {
//        currentMembers.remove(at: index)
//    }
//}
//
//func requiredCountForTotal() -> Int {
//    return requiredPositions.reduce(0) { result, position in
//        return result + position.requiredFieldCount
//    }
//}
//
//func requiredCountPerField(field: Field) -> Int {
//    return requiredPositions.first(where: { $0.field == field })?.requiredFieldCount ?? 0
//}
//
//func currentCount(field: Field) -> Int {
//    return currentMembers.filter { $0.field == field }.count
//}
//
//func requiredCountPerFieldDic() -> [Field : Int] {
//    var dictionary = [Field : Int]()
//
//    requiredPositions.forEach {
//        dictionary[$0.field] = $0.requiredFieldCount
//    }
//
//    currentMembers.forEach {
//        if let existingField = dictionary[$0.field] {
//            dictionary[$0.field] = existingField - 1
//        }
//    }
//
//    return dictionary
//}
