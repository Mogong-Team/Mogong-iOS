//
//  StudyViewModel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI
import Combine

class StudyViewModel: ObservableObject {
    
    static let shared = StudyViewModel()

    @Published var allStudys = [Study]()
    @Published var filteredWithCategoryStudys = [Study]()
    @Published var filteredWithBookmarkStudy = [Study]()
    @Published var filteredStudys = [Study]()
    //@Published var selectedStudy: Study?
    @Published var selectedStudy: Study = Study.study2
    
    // MARK: - 스터디리스트
    
    @Published var selectedCategory: StudyCategory = .all
    @Published var selectedState: StudyState?
    @Published var isPopularFilter: Bool = true
    @Published var isBookmarked: Bool = false
    @Published var showStudyDetail: Bool = false
    @Published var showCreateStudyOnList: Bool = false
    
    // MARK: - 스터디 상세
    
    @Published var presentApplicationStudy: Bool = false
    @Published var presentTest: Bool = false
    @Published var checkSubimt: Bool = false
    @Published var checkMember: Bool = false
    @Published var checkHost: Bool = false
    @Published var showCreateStudyOnDetail: Bool = false

    // MARK: - 스터디 생성
    
    @Published var stateForCreateStudy: stateForCreateStudy = .new
    
    @Published var category: StudyCategory?
    @Published var location: StudyLocation?
    @Published var title: String = ""
    @Published var introduction: String = ""
    @Published var goal: String = ""
    @Published var memberPreference: String = ""
    @Published var dueDate: Date = Date()
    
    @Published var frequencyOfWeek: Int = 0
    @Published var durationOfMonth: Int = 0
    @Published var language: [Language] = []
    @Published var numberOfRecruits: Int = 0

    @Published var hostPosition: Position?
    @Published var positionInfoBackend: PositionInfo?
    @Published var positionInfoFrontend: PositionInfo?
    @Published var positionInfoiOS: PositionInfo?
    @Published var positionInfoAOS: PositionInfo?
    @Published var positionInfoCross: PositionInfo?
    @Published var positionInfoDesigner: PositionInfo?
    @Published var positionInfoPlanner: PositionInfo?
    @Published var revenuePurpose: RevenuePurpose?
        
    var positionInfos: [PositionInfo] {
        return [positionInfoBackend, positionInfoFrontend, positionInfoiOS, positionInfoAOS, positionInfoCross, positionInfoDesigner, positionInfoPlanner].compactMap { $0 }
    }
    
    // MARK: - 마이스터디
    
    @Published var myAllStudys = [Study]()
    @Published var filterdOngoingMyStudy = [Study]()
    @Published var filterdEndedMyStudy = [Study]()
    @Published var selectedMyStudyStateIsEnded: Bool = false
    @Published var selectedMyStudyIndex: Int = 0
    @Published var showRemoveMember: Bool = false
    
    //MARK: - 내보내기
    
    @Published var selectedMember: Member?
    @Published var removeReason: String = ""
    
    //MARK: - 기타
    
    @Published var searchQuery: String = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        //initStudys()
        
        $myAllStudys
            .map { $0.filter { $0.state != .ended } }
            .sink { [weak self] filterdStudys in
                self?.filterdOngoingMyStudy = filterdStudys
            }
            .store(in: &cancellables)

        $myAllStudys
            .map { $0.filter { $0.state == .ended }}
            .sink { [weak self] filterdStudys in
                self?.filterdEndedMyStudy = filterdStudys
            }
            .store(in: &cancellables)
        
        $myAllStudys
            .map { $0.first }
            .compactMap { $0 }
            .sink { [weak self] selectedStudy in
                self?.selectedStudy = selectedStudy
            }
            .store(in: &cancellables)
        
        $selectedCategory
            .sink { [weak self] in
                self?.filteringStudyWithCategory(category: $0)
            }
            .store(in: &cancellables)
        
        $selectedState
            .sink { [weak self] in
                self?.filteringStudyWithState(state: $0 ?? .recruiting)
            }
            .store(in: &cancellables)
    }
    
    //MARK: 스터디 필터링
    
    func filteringStuddyWithBookmark() {
        self.filteredWithBookmarkStudy = self.allStudys.filter { $0.bookMarkedUsers.contains(UserViewModel.shared.currentUser.id) }
    }
    
    func filteringStudyWithState(state: StudyState) {
        self.filteredStudys = self.filteredWithCategoryStudys.filter { $0.state == state }
    }
    
    func filteringStudyWithCategory(category: StudyCategory) {
        self.selectedState = nil
        
        if category == .all {
            self.filteredWithCategoryStudys = self.allStudys
            self.filteredStudys = self.filteredWithCategoryStudys
        } else {
            let filteredWithCategoryStudys = allStudys.filter { $0.category == category }
            self.filteredWithCategoryStudys = filteredWithCategoryStudys
            self.filteredStudys = self.filteredWithCategoryStudys
        }
    }
    
    //MARK: 스터디
    
    func createStudy() {
        let study = Study(
            category: category ?? .generalStudy,
            loaction: location ?? .online,
            title: title,
            introduction: introduction,
            goal: goal,
            memberPreference: memberPreference,
            dueDate: dueDate,
            frequencyOfWeek: frequencyOfWeek,
            durationOfMonth: durationOfMonth,
            languages: language,
            numberOfRecruits: numberOfRecruits,
            positionInfos: positionInfos,
            host: UserViewModel.shared.currentUser,
            currentMembers: [Member(user: UserViewModel.shared.currentUser, position: hostPosition ?? .ios)]
        )
        
        let userId = UserViewModel.shared.currentUser.id
        
        // TODO: POST Study
        StudyService.createStudy(study: study) {
            print("스터디 생성 완료")
            self.resetCreateStudy()
            
            UserService.addJoinedStudyIds(userId: userId, studyId: study.id) { error in
                if let error = error {
                    print("스터디 생성 후 유저 업데이트 실패: ", error.localizedDescription)
                } else {
                    UserService.getUser(userId: userId) { result in
                        switch result {
                        case .success(let user):
                            UserViewModel.shared.currentUser = user
                        case .failure(let error):
                            print("유저 정보 가져오기 실패: ", error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    func updateStudy() {
        var study = self.selectedStudy
        study.category = category ?? .generalStudy
        study.loaction = location ?? .both
        study.title = title
        study.introduction = introduction
        study.goal = goal
        study.memberPreference = memberPreference
        study.dueDate = dueDate
        study.frequencyOfWeek = frequencyOfWeek
        study.durationOfMonth = durationOfMonth
        study.languages = language
        study.numberOfRecruits = numberOfRecruits
        study.positionInfos = positionInfos
        
        // TODO: POST Study
        StudyService.updateStudy(study: study) { error in
            if let error = error {
                print("스터디 수정 실패: ", error.localizedDescription)
            }
            self.resetCreateStudy()
        }
    }

    func getAllStudys() {
        StudyService.getAllStudys { result in
            switch result {
            case .success(let studys):
                self.allStudys.removeAll()
                self.allStudys = studys
                self.filteredStudys.removeAll()
                self.filteredStudys = studys
            case .failure(let error):
                print("스터디 받아오기 실패 :", error.localizedDescription)
            }
        }
    }
    
    func getStudyWithId(completion: @escaping () -> Void) {
        StudyService.getStudyById(studyId: selectedStudy.id) { result in
            switch result {
            case .success(let study):
                self.selectedStudy = study
                completion()
            case .failure(let error):
                print("선택된 스터디 정보 업데이트 실패: ", error.localizedDescription)
            }
        }
    }
    
    func getUserStudys() {
        StudyService.getUserStudys { result in
            switch result {
            case .success(let studys):
                self.myAllStudys = studys
            case .failure(let error):
                print("마아스터디 받아오기 실패: ", error.localizedDescription)
            }
        }
    }
    
    //MARK: 북마크

    func checkBookmark(study: Study) -> Bool {
        return study.bookMarkedUsers.contains(UserViewModel.shared.currentUser.id)
    }
    
    func updateBookmark() {
        let userId = UserViewModel.shared.currentUser.id
        let study = self.selectedStudy
        let studyId = self.selectedStudy.id
        
        if checkBookmark(study: study) {
            StudyService.deleteBookmarkedUser(studyId: studyId, userId: userId) { error in
                if let error = error {
                    print("스터디 북마크 삭제 실패: ", error.localizedDescription)
                } else {
                    StudyService.getStudyById(studyId: studyId) { result in
                        switch result {
                        case .success(let study):
                            self.selectedStudy = study
                        case .failure(let error):
                            print("북마크 추가 후 스터디 정보 업데이트 실패: ", error.localizedDescription)
                        }
                    }
                }
            }
            
            UserService.deleteBookmarkedStudyIds(userId: userId, studyId: studyId) { error in
                if let error = error {
                    print("유저 북마크 삭제 실패: ", error.localizedDescription)
                } else {
                    UserService.getUser(userId: userId) { result in
                        switch result {
                        case .success(let user):
                            UserViewModel.shared.currentUser = user
                        case .failure(let error):
                            print("북마크 추가 후 유저 정보 업데이트 실패: ", error.localizedDescription)
                        }
                    }
                }
            }
        } else {
            StudyService.addBookmarkedUser(studyId: studyId, userId: userId) { error in
                if let error = error {
                    print("스터디 북마크 추가 실패: ", error.localizedDescription)
                } else {
                    StudyService.getStudyById(studyId: studyId) { result in
                        switch result {
                        case .success(let study):
                            self.selectedStudy = study
                        case .failure(let error):
                            print("북마크 삭제 후 스터디 정보 업데이트 실패: ", error.localizedDescription)
                        }
                    }
                }
            }
            
            UserService.addBookmarkedStudyIds(userId: userId, studyId: studyId) { error in
                if let error = error {
                    print("유저 북마크 추가 실패: ", error.localizedDescription)
                } else {
                    UserService.getUser(userId: userId) { result in
                        switch result {
                        case .success(let user):
                            UserViewModel.shared.currentUser = user
                        case .failure(let error):
                            print("북마크 삭제 후 유저 정보 업데이트 실패: ", error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    //MARK: 내보내기
    
    func removeMember() {
        guard let removedMember = selectedMember else { return
            print("선택된 유저 정보 없음")
        }
        
        var updatedStudy = selectedStudy
        updatedStudy.currentMembers.removeAll(where: { $0.user.id == removedMember.user.id })
        var updatedUser = removedMember.user
        updatedUser.joinedStudyIds.removeAll(where: { $0 == updatedStudy.id })
        
        StudyService.updateStudy(study: updatedStudy) { error in
            if let error = error {
                print("스터디에서 유저 내보내기 실패: ", error.localizedDescription)
            }
        }
        
        UserService.updateUser(user: updatedUser) { error in
            if let error = error {
                print("내보내진 유저 정보 업데이트 실패: ", error.localizedDescription)
            }
        }
        
        guard let removedApplicationId = updatedUser.submittedApplicationIds.first(where: { updatedStudy.submittedApplications.contains($0) }) else { return
            print("내보내진 유저의 신청서 정보 없음")
        }
        
        ApplicationService.deleteApplication(applicationId: removedApplicationId) { error in
            if let error = error {
                print("내보내진 유저의 신청서 삭제 실패: ", error.localizedDescription)
            }
        }
    }

    //MARK: 기타
    
    func checkStudyDetailState() {
        if let _ = selectedStudy.currentMembers.first(where: { $0.user.id == UserViewModel.shared.currentUser.id }) {
            checkMember = true
        } else {
            self.checkMember = false
            
            if UserViewModel.shared.currentUser.id == selectedStudy.host.id {
                self.checkHost = true
            } else {
                self.checkHost = false
                
                let studyApplicationIds = selectedStudy.submittedApplications
                let userApplicationIds = UserViewModel.shared.currentUser.submittedApplicationIds
                self.checkSubimt = studyApplicationIds.contains{ userApplicationIds.contains($0) }
            }
        }
    }
    
    func isHostUser(study: Study, member: Member) -> Bool {
        return study.host.id == member.user.id
    }
    
    func numberOfRecruits(study: Study) -> Int {
        return study.positionInfos
            .map { $0.requiredCount }
            .filter { $0 != 0 }
            .reduce(0, +)
    }
    
    func positions(study: Study) -> String {
        return study.positionInfos
            .filter { $0.requiredCount != 0 }
            .map { $0.position.rawValue }
            .joined(separator: " / ")
    }
    
    func setPositionInfo(position: Position, positionInfo: PositionInfo) {
        switch position {
        case .backend:
            positionInfoBackend = positionInfo
        case .frontend:
            positionInfoFrontend = positionInfo
        case .ios:
            positionInfoiOS = positionInfo
        case .aos:
            positionInfoAOS = positionInfo
        case .cross:
            positionInfoCross = positionInfo
        case .designer:
            positionInfoDesigner = positionInfo
        case .planner:
            positionInfoPlanner = positionInfo
        }
    }
    
    func getPositionInfoText(_ positionInfo: PositionInfo?) -> String {
        guard let info = positionInfo else { return "0명" }
        
        let requiredCount = info.requiredCount
        let languages = info.language.map { $0.rawValue }.map { "/ \($0)" }.joined(separator: " ")
        return "\(requiredCount)명 \(languages)"
    }

    func setPositionInfoText(position: Position) -> String {
        switch position {
        case .backend:
            return getPositionInfoText(positionInfoBackend)
        case .frontend:
            return getPositionInfoText(positionInfoFrontend)
        case .ios:
            return getPositionInfoText(positionInfoiOS)
        case .aos:
            return getPositionInfoText(positionInfoAOS)
        case .cross:
            return getPositionInfoText(positionInfoCross)
        case .designer:
            return getPositionInfoText(positionInfoDesigner)
        case .planner:
            return getPositionInfoText(positionInfoPlanner)
        }
    }
    
    func resetCreateStudy() {
        category = nil
        location = nil
        title = ""
        introduction = ""
        goal = ""
        memberPreference = ""
        dueDate = Date()
        
        frequencyOfWeek = 0
        durationOfMonth = 0
        language = []
        numberOfRecruits = 0
        
        hostPosition = nil
        positionInfoBackend = nil
        positionInfoFrontend = nil
        positionInfoiOS = nil
        positionInfoAOS = nil
        positionInfoCross = nil
        positionInfoDesigner = nil
        positionInfoPlanner = nil
        revenuePurpose = nil
    }
    
    func updateCreateStudy() {
        category = selectedStudy.category
        location = selectedStudy.loaction
        title = selectedStudy.title
        introduction = selectedStudy.introduction
        goal = selectedStudy.goal
        memberPreference = selectedStudy.memberPreference
        dueDate = Date()
        
        frequencyOfWeek = selectedStudy.frequencyOfWeek
        durationOfMonth = selectedStudy.durationOfMonth
        language = selectedStudy.languages
        numberOfRecruits = selectedStudy.numberOfRecruits
        
        let host = selectedStudy.currentMembers.first(where: { $0.user.id == UserViewModel.shared.currentUser.id })
        
        hostPosition = host?.position ?? .ios
        positionInfoBackend = selectedStudy.positionInfos.first(where: { $0.position == .backend })
        positionInfoFrontend = selectedStudy.positionInfos.first(where: { $0.position == .frontend })
        positionInfoiOS = selectedStudy.positionInfos.first(where: { $0.position == .ios })
        positionInfoAOS = selectedStudy.positionInfos.first(where: { $0.position == .aos })
        positionInfoCross = selectedStudy.positionInfos.first(where: { $0.position == .cross })
        positionInfoDesigner = selectedStudy.positionInfos.first(where: { $0.position == .designer })
        positionInfoPlanner = selectedStudy.positionInfos.first(where: { $0.position == .planner })
        revenuePurpose = selectedStudy.revenuePurpose
    }
}

extension StudyViewModel {
    enum stateForCreateStudy {
        case new
        case update
    }
}
