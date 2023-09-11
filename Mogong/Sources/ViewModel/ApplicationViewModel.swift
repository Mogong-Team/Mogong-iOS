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
    
    @Published var alreadySubmittedStudy: Bool = false
    
    var cancellables = Set<AnyCancellable>()

    func checkAlreadySubmittedStudy(study: Study) {
        let studyApplicationIds = study.submittedApplications
        let userApplicationIds = UserViewModel.shared.currentUser.submittedApplicationIds
        self.alreadySubmittedStudy = studyApplicationIds.contains{ userApplicationIds.contains($0) }
        print("alreadySubmittedStudy 업데이트 후: ", alreadySubmittedStudy)
    }
    
    func submitApplication(study: Study) {
        let application = Application(
            user: UserViewModel.shared.currentUser,
            studyId: study.id,
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
            
            StudyService.addApplicationId(studyId: study.id, applicationId: application.id) { error in
                if let error = error {
                    print("신청서 제출 후 스터디 업데이트 실패: ", error.localizedDescription)
                }
                print("신청서 제출 후 스터디 업데이트 성공")
            }
            
            UserService.addApplicationId(userId: UserViewModel.shared.currentUser.id, applicationId: application.id) { error in
                if let error = error {
                    print("신청서 제출 후 유저 업데이트 실패: ", error.localizedDescription)
                }
                print("신청서 제출 후 유저 업데이트 성공")
                
                UserService.getUser(userId: UserViewModel.shared.currentUser.id) { result in
                    switch result {
                    case .success(let user):
                        UserViewModel.shared.currentUser = user
                        print("유저 정보 가져오기 성공")
                    case .failure(let error):
                        print("유저 정보 가져오기 실패: ", error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func deleteApplication(study: Study) {
        let studyApplicationIds = study.submittedApplications
        let userApplicationIds = UserViewModel.shared.currentUser.submittedApplicationIds
        
        guard let applicationId = studyApplicationIds.first(where: { userApplicationIds.contains($0) }) else {
            print(StudyViewModel.shared.selectedStudy.submittedApplications)
            print(UserViewModel.shared.currentUser.submittedApplicationIds)
            print("applicationId 획득 실패")
            return }
        
        ApplicationService.deleteApplication(applicationId: applicationId) { error in
            if error != nil {
                print("신청서 삭제하기 실패")
            }
            print("신청서 삭제하기 성공")
            
            StudyService.deleteApplicationId(studyId: study.id, applicationId: applicationId) { error in
                if error != nil {
                    print("신청서 삭제 후 스터디 업데이트 실패")
                }
            }
            
            UserService.deleteApplicationId(userId: UserViewModel.shared.currentUser.id, applicationId: applicationId) { erro in
                if error != nil {
                    print("신청서 삭제 후 유저 업데이트 실패")
                }
                print("신청서 삭제 후 유저 업데이트 성공")
                
                UserService.getUser(userId: UserViewModel.shared.currentUser.id) { result in
                    switch result {
                    case .success(let user):
                        UserViewModel.shared.currentUser = user
                        print("유저 정보 가져오기 성공")
                    case .failure(let error):
                        print("유저 정보 가져오기 실패: ", error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func getStudyApplication(studyId: String) {
        ApplicationService.getStudyAllApplications(studyId: studyId) { result in
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
