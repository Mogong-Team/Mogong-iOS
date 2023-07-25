//
//  StudyViewModel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI
import Combine

class StudyViewModel: ObservableObject {
    
    @Published var studys2 = [Study2]()
    @Published var studys = [Study]()
    //@Published var selectedStudy: Study = Study.tempStudy
    @Published var selectedStudy: Study = Study.study1
    
    // MARK: - 스터디리스트
    
    @Published var selectedCategory: StudyCategory = .all
    @Published var selectedState: StudyState?
    @Published var isPopularFilter: Bool = true
    @Published var isBookmarked: Bool = false
    @Published var presentStudyDetail: Bool = false
    
    // MARK: - 스터디 생성
    
    @Published private var category: StudyCategory?
    @Published private var state: StudyState?
    @Published private var title: String = ""
    @Published private var introduction: String = ""
    @Published private var goal: String = ""
    @Published private var memberPreference: String = ""
    @Published private var dueDate: Date = Date()
    @Published private var showDatePicker = false
    
    @Published private var frequencyOfWeek: Int = 0
    @Published private var durationOfMonth: Int = 0
    @Published private var language: Field?
    @Published private var numberOfRecruits: Int = 0

    @Published private var hostPosition: Field?
    @Published private var backendNeedCount: String = ""
    @Published private var frontendNeedCount: String = ""
    @Published private var aosNeedCount: String = ""
    @Published private var iosNeedCount: String = ""
    @Published private var designerNeedCount: String = ""
    @Published private var selectProfitGoal: ProfitGoal?
    
    // MARK: - 마이스터디
    
    /// 모든 스터디에서 마이스터디 가져오는 방법
    /// 1) viewModel에서 필터링 - 데이터량이 적으면 서버와 연동보다  받아온 모든 스터디에서 필터링하는게 빠름
    /// 2) 서버에서 받아오기 - 이용자 수가 많을 수록 필요성 높아짐
    @Published var myStudys = [Study2]()
    @Published var myStudyFilterdOngoingStudy = [Study2]()
    @Published var myStudyFilterdCompletedStudy = [Study2]()
    @Published var myStudyStateIsOngoing: Bool = true
    @Published var myStudySelectedStudyIndex: Int = 0
    @Published var myStudyshowRemoveSheet: Bool = false
    
    //MARK: - 기타
    
    @Published var searchQuery: String = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        initStudys2()
        initStudys()
        
        $studys2
            .map { $0.filter { !$0.isStudyCompleted }}
            .sink { [weak self] filterdStudys in
                self?.myStudyFilterdOngoingStudy = filterdStudys
            }
            .store(in: &cancellables)
        
        $studys2
            .map { $0.filter { $0.isStudyCompleted }}
            .sink { [weak self] filterdStudys in
                self?.myStudyFilterdCompletedStudy = filterdStudys
            }
            .store(in: &cancellables)
    }

    func isHostUser(study: Study2, member: Member) -> Bool {
        return study.host.user.id == member.user.id
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
