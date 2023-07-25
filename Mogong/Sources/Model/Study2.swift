//
//  Study.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI

enum StudyType: String, CaseIterable {
    case study = "스터디"
    case teamProject = "팀 프로젝트"
}

enum StudyMode: String, CaseIterable {
    case online = "온라인"
    case offline = "오프라인"
    case both = "온/오프라인"
}

enum Field: String, CaseIterable, Codable {
    case frontend = "프론트엔드"
    case backend = "백엔드"
    case designer = "디자이너"
    case aos = "AOS"
    case ios = "iOS"
}

enum ProfitGoal: String, CaseIterable {
    case yes = "있음"
    case no = "없음"
}

struct Member: Hashable {
    let user: User
    let field: Field
    
    init(user: User, field: Field) {
        self.user = user
        self.field = field
    }
    
    static var member1 = Member(user: User.user1, field: .backend)
}

struct Position: Hashable {
    let field: Field
    var requiredFieldCount: Int = 0 // requiredFieldCount
    var currentCount: Int = 0
}

struct Study2: Identifiable, Hashable {
    let id: String
    let title: String
    let frequencyOfWeek: Int
    let durationOfMonth: Int
    let studyType: StudyType
    let studyMode: StudyMode
    let totalMemberCount: Int
    var requiredPositions: [Position]
    let host: Member
    var currentMembers: [Member]
    let introduction: String
    let memberPreference: String
    let hashtags: [String]
    let createDate: Date
    let dueDate: Date
    let languages: [Language]
    let fields: [Field]
    let profitGoal: ProfitGoal
    let bookMarkCount: Int
    
    let isBookMarked: Bool
    let isRecruitmentCompleted: Bool
    let isStudyCompleted: Bool

    init(title: String, frequencyOfWeek: Int, durationOfMonth: Int, studyType: StudyType ,studyMode: StudyMode, totalMemberCount: Int, requiredPositions: [Position], host: Member, introduction: String, memberPreference: String, hashtags: [String], dueDate: Date, languages: [Language], fields: [Field], profitGoal: ProfitGoal, isBookMarked: Bool, isRecruitmentCompleted: Bool) {
        self.id = UUID().uuidString
        self.title = title
        self.frequencyOfWeek = frequencyOfWeek
        self.durationOfMonth = durationOfMonth
        self.studyType = studyType
        self.studyMode = studyMode
        self.totalMemberCount = totalMemberCount
        self.requiredPositions = requiredPositions
        self.host = host
        self.currentMembers = []
        self.introduction = introduction
        self.memberPreference = memberPreference
        self.hashtags = hashtags
        self.createDate = Date()
        self.dueDate = dueDate
        self.languages = languages
        self.fields = fields
        self.profitGoal = profitGoal
        self.bookMarkCount = 0
        self.isBookMarked = isBookMarked
        self.isRecruitmentCompleted = isRecruitmentCompleted
        self.isStudyCompleted = false
    }
    
    init(id: String, title: String, frequencyOfWeek: Int, durationOfMonth: Int, studyType: StudyType, studyMode: StudyMode, totalMemberCount: Int, requiredPositions: [Position], host: Member, currentMember: [Member], introduction: String, memberPreference: String, hashtags: [String], createDate: Date, dueDate: Date, languages: [Language], fields: [Field], profitGoal: ProfitGoal, isBookMarked: Bool, bookMarkCount: Int, isRecruitmentCompleted: Bool, isStudyCompleted: Bool) {
        self.id = id
        self.title = title
        self.frequencyOfWeek = frequencyOfWeek
        self.durationOfMonth = durationOfMonth
        self.studyType = studyType
        self.studyMode = studyMode
        self.totalMemberCount = totalMemberCount
        self.requiredPositions = requiredPositions
        self.host = host
        self.currentMembers = currentMember
        self.introduction = introduction
        self.memberPreference = memberPreference
        self.hashtags = hashtags
        self.createDate = createDate
        self.dueDate = dueDate
        self.languages = languages
        self.fields = fields
        self.profitGoal = profitGoal
        self.bookMarkCount = bookMarkCount
        self.isBookMarked = isBookMarked
        self.isRecruitmentCompleted = isRecruitmentCompleted
        self.isStudyCompleted = isStudyCompleted
    }
    
    mutating func addMember(_ member: Member) {
        if let index = requiredPositions.firstIndex(where: { $0.field == member.field }) {
            requiredPositions[index].currentCount += 1
        }
        
        currentMembers.append(member)
    }
    
    mutating func removeMember(_ member: Member) {
        if let index = requiredPositions.firstIndex(where: { $0.field == member.field }) {
            requiredPositions[index].currentCount -= 1
        }
        
        if let index = currentMembers.firstIndex(where: { $0.user.id == member.user.id }) {
            currentMembers.remove(at: index)
        }
    }
    
    func requiredCountForTotal() -> Int {
        return requiredPositions.reduce(0) { result, position in
            return result + position.requiredFieldCount
        }
    }
    
    func requiredCountPerField(field: Field) -> Int {
        return requiredPositions.first(where: { $0.field == field })?.requiredFieldCount ?? 0
    }
    
    func currentCount(field: Field) -> Int {
        return currentMembers.filter { $0.field == field }.count
    }
    
    func requiredCountPerFieldDic() -> [Field : Int] {
        var dictionary = [Field : Int]()
        
        requiredPositions.forEach {
            dictionary[$0.field] = $0.requiredFieldCount
        }
        
        currentMembers.forEach {
            if let existingField = dictionary[$0.field] {
                dictionary[$0.field] = existingField - 1
            }
        }
        
        return dictionary
    }
}

extension StudyViewModel {
    func initStudys2() {
        studys2 = [
        Study2(id: "1", title: "[창업/스타트업] 정부 지원 사업에 합격한 아이템으로 함께 MVP 제작할 개발자 구합니다.(2일 뒤 마감_편하게 연락주세요)", frequencyOfWeek: 2, durationOfMonth: 2,
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
              createDate: Date(), dueDate: Date(timeIntervalSinceNow: 24*3600*1), languages: [.javaScript, .figma, .swift],
              fields: [.backend, .designer], profitGoal: .no,
              isBookMarked: true, bookMarkCount: 5, isRecruitmentCompleted: false, isStudyCompleted: false),
        
        Study2(id: "2", title: "스터디2 함께해요.", frequencyOfWeek: 2, durationOfMonth: 2,
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
        
        Study2(id: "3", title: "스터디3 함께해요.", frequencyOfWeek: 2, durationOfMonth: 2,
              studyType: .teamProject, studyMode: .online, totalMemberCount: 5,
              requiredPositions: [
                Position(field: .backend, requiredFieldCount: 2),
                Position(field: .frontend, requiredFieldCount: 1),
                Position(field: .designer, requiredFieldCount: 1),
                Position(field: .ios, requiredFieldCount: 1)
              ],
              host:
                Member(user: User(id: "3", name: "김정수", email: "a@gmail.com", username: "정수정수"),  field: .ios),
              currentMember: [
                Member(user: User(id: "1", name: "김민수", email: "a@gmail.com", username: "민수민수"), field: .backend),
                Member(user: User(id: "2", name: "김종민", email: "a@gmail.com", username: "종민종민"), field: .frontend),
                Member(user: User(id: "3", name: "김정수", email: "a@gmail.com", username: "정수정수"),  field: .ios),
                Member(user: User(id: "4", name: "김나연", email: "a@gmail.com", username: "나연나연"),  field: .designer),
              ],
              introduction: "안녕하세요", memberPreference: "누구든 상관없어요", hashtags: ["#자바스크립트", "#앱개발", "#디자이너"],
              createDate: Date(), dueDate: Date(timeIntervalSinceNow: -24*3600*7), languages: [.javaScript, .figma, .swift],
              fields: [.backend, .designer], profitGoal: .no,
              isBookMarked: true, bookMarkCount: 5, isRecruitmentCompleted: false, isStudyCompleted: true),
        
        Study2(id: "4", title: "스터디4 함께해요.", frequencyOfWeek: 2, durationOfMonth: 2,
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
              createDate: Date(), dueDate: Date(timeIntervalSinceNow: -24*3600*7), languages: [.javaScript, .figma, .swift],
              fields: [.backend, .designer], profitGoal: .no,
              isBookMarked: true, bookMarkCount: 5, isRecruitmentCompleted: false, isStudyCompleted: true),
        ]
    }
}
