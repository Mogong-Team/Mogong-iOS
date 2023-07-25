//
//  StudyViewModel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI
import Combine

class StudyViewModel: ObservableObject {
    
    @Published var studys = [Study]()
    //@Published var selectedStudy: Study?
    @Published var selectedStudy: Study = Study.study1
    
    // MARK: - 스터디리스트
    
    @Published var selectedCategory: StudyCategory = .all
    @Published var selectedState: StudyState?
    @Published var isPopularFilter: Bool = true
    @Published var isBookmarked: Bool = false
    @Published var presentStudyDetail: Bool = false
    
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
    @Published var language: Language?
    @Published var numberOfRecruits: Int = 0

    @Published var hostPosition: Position2?
    @Published var backendPositionInfo: PositionInfo?
    @Published var frontendPositionInfo: PositionInfo?
    @Published var aosPositionInfo: PositionInfo?
    @Published var iosPositionInfo: PositionInfo?
    @Published var designerPositionInfo: PositionInfo?
    @Published var plannerPositionInfo: PositionInfo?
    @Published var revenuePurpose: RevenuePurpose?
    
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
        initStudys()
        
        $studys
            .map { $0.filter { $0.state != .ended } }
            .sink { [weak self] filterdStudys in
                self?.filterdOngoingMyStudy = filterdStudys
            }
            .store(in: &cancellables)

        $studys
            .map { $0.filter { $0.state == .ended }}
            .sink { [weak self] filterdStudys in
                self?.filterdEndedMyStudy = filterdStudys
            }
            .store(in: &cancellables)
    }

    func isHostUser(study: Study, member: Member2) -> Bool {
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
}
