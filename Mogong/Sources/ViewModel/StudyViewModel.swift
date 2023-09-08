//
//  StudyViewModel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI
import Combine

class StudyViewModel: ObservableObject {
    
    @Published var allStudys = [Study]()
    @Published var filteredWithCategoryStudys = [Study]()
    @Published var filteredWithBookmarkStudy = [Study]()
    @Published var filteredStudys = [Study]()
    //@Published var selectedStudy: Study?
    @Published var selectedStudy: Study = Study.study1
    
    // MARK: - 스터디리스트
    
    @Published var selectedCategory: StudyCategory = .all
    @Published var selectedState: StudyState?
    @Published var isPopularFilter: Bool = true
    @Published var isBookmarked: Bool = false
    @Published var presentStudyDetail: Bool = false
    @Published var presentCreateStudy: Bool = false
    
    // MARK: - 스터디 상세
    
    @Published var presentApplicationStudy: Bool = false
    @Published var presentTest: Bool = false
    
    // MARK: - 스터디 생성
    
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
    
    let studyService = StudyService()
    
    var positionInfos: [PositionInfo] {
        return [positionInfoBackend, positionInfoFrontend, positionInfoiOS, positionInfoAOS, positionInfoCross, positionInfoDesigner, positionInfoPlanner].compactMap { $0 }
    }
    
    // MARK: - 마이스터디
    
    /// 모든 스터디에서 마이스터디 가져오는 방법
    /// 1) viewModel에서 필터링 - 데이터량이 적으면 서버와 연동보다  받아온 모든 스터디에서 필터링하는게 빠름
    /// 2) 서버에서 받아오기 - 이용자 수가 많을 수록 필요성 높아짐
    @Published var filterdOngoingMyStudy = [Study]()
    @Published var filterdEndedMyStudy = [Study]()
    @Published var selectedMyStudyStateIsEnded: Bool = false
    @Published var selectedMyStudyIndex: Int = 0
    @Published var showRemoveMember: Bool = false
    
    //MARK: - 기타
    
    @Published var searchQuery: String = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        //initStudys()
        
        $allStudys
            .map { $0.filter { $0.state != .ended } }
            .sink { [weak self] filterdStudys in
                self?.filterdOngoingMyStudy = filterdStudys
            }
            .store(in: &cancellables)

        $allStudys
            .map { $0.filter { $0.state == .ended }}
            .sink { [weak self] filterdStudys in
                self?.filterdEndedMyStudy = filterdStudys
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
    
    func createStudy() {
        // TODO: POST Study
        studyService.createStudy(study: Study.study4) {
            print("완료")
        }
    }

    func getAllStudys() {
//        studyService.getAllStudies { studys, error in
//            if let error = error {
//                print("스터디 받아오기 실패")
//            } else {
//                print("스터디 받아오기 성공")
//                guard let studys = studys else { return }
//                self.allStudys.removeAll()
//                self.allStudys = studys
//                self.filteredStudys.removeAll()
//                self.filteredStudys = studys
//            }
//        }
        
        studyService.getAllStudys { result in
            switch result {
            case .success(let studys):
                print("스터디 받아오기 성공")
                self.allStudys.removeAll()
                self.allStudys = studys
                self.filteredStudys.removeAll()
                self.filteredStudys = studys
            case .failure(let error):
                print("스터디 받아오기 실패 :", error.localizedDescription)
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
            studyService.deleteBookmarkedUser(studyId: studyId, userId: userId) { error in
                if let error = error {
                    print("스터디 북마크 삭제 실패", error.localizedDescription)
                } else {
                    UserService.deleteBookmarkedStudyIds(userId: userId, studyId: studyId) { error in
                        if let error = error {
                            print("유저 북마크 삭제 실패", error.localizedDescription)
                        } else {
                            self.studyService.getAllStudys { result in
                                switch result {
                                case .success(let study):
                                    self.allStudys = study
                                case .failure(let error):
                                    print("북마크 추가 후 전체 스터디 정보 업데이트 실패: ", error.localizedDescription)
                                }
                            }
                            
                            self.studyService.getStudyById(studyId: studyId) { result in
                                switch result {
                                case .success(let study):
                                    self.selectedStudy = study
                                case .failure(let error):
                                    print("북마크 추가 후 스터디 정보 업데이트 실패: ", error.localizedDescription)
                                }
                            }
                            
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
                }
            }
        } else {
            studyService.addBookmarkedUser(studyId: studyId, userId: userId) { error in
                if let error = error {
                    print("스터디 북마크 추가 실패", error.localizedDescription)
                } else {
                    UserService.addBookmarkedStudyIds(userId: userId, studyId: studyId) { error in
                        if let error = error {
                            print("유저 북마크 추가 실패", error.localizedDescription)
                        } else {
                            self.studyService.getAllStudys { result in
                                switch result {
                                case .success(let study):
                                    self.allStudys = study
                                case .failure(let error):
                                    print("북마크 삭제 후 전체 스터디 정보 업데이트 실패: ", error.localizedDescription)
                                }
                            }
                            
                            self.studyService.getStudyById(studyId: studyId) { result in
                                switch result {
                                case .success(let study):
                                    self.selectedStudy = study
                                case .failure(let error):
                                    print("북마크 삭제 후 스터디 정보 업데이트 실패: ", error.localizedDescription)
                                }
                            }
                            
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
        }
    }
}
