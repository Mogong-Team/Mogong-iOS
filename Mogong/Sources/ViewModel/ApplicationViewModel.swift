//
//  ApplicationViewModel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/29.
//

import SwiftUI
import Combine

class ApplicationViewModel: ObservableObject {
    
    @Published var applications: [Application] = []
    
    @Published var title: String = ""
    @Published var position: Position?
    @Published var introduction: String = ""
    @Published var experience: String = ""
    
    var cancellables = Set<AnyCancellable>()
    
//    func fetchApplications(user: User) {
//        applicationService.fetchApplications { result in
//            switch result {
//            case .success(let applications):
//                DispatchQueue.main.async {
//                    Application.applications = applications.filter { $0.user.id == user.id }
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    func submitApplication(studyId: String) {
        let application = Application(
            user: UserViewModel.shared.currentUser,
            studyId: studyId,
            title: title,
            position: position ?? .ios,
            introduction: introduction,
            experience: experience)
        
        ApplicationService.submitApplication(application: application) { error in
            if let error = error {
                print("신청서 제출하기 실패: ", error.localizedDescription)
            }
            print("신청서 제출하기 성공")
            self.resetSubmitApplication()
        }
    }
    
    func getAllStudyApplication(studyId: String) {
        ApplicationService.getAllStudyApplications(studyId: studyId) { result in
            switch result {
            case .success(let applications):
                self.applications = applications
            case .failure(let error):
                print("신청서 가져오기 실패", error.localizedDescription)
            }
        }
    }
    
    // 신청서 승인
    func approveApplication(index: Int) {
    }
    
    // 신청서 거절
    func rejectApplication(index: Int) {
    }
    
    func resetSubmitApplication() {
        title = ""
        position = nil
        introduction = ""
        experience = ""
    }
}
