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
    @Published var selectedApplication: Application = Application.application1
    
    @Published var title: String = ""
    @Published var position: Position?
    @Published var introduction: String = ""
    @Published var experience: String = ""
    
    @Published var presentApplicationDetailView: Bool = false
        
    var cancellables = Set<AnyCancellable>()
    
    func submitApplication(study: Study, completion: @escaping () -> Void) {
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
            
            self.resetSubmitApplication()
        }
        
        StudyService.addApplicationId(studyId: study.id, applicationId: application.id) { error in
            if let error = error {
                print("신청서 제출 후 스터디 업데이트 실패: ", error.localizedDescription)
            } else {
                completion()
            }
        }
        
        UserService.addApplicationId(userId: UserViewModel.shared.currentUser.id, applicationId: application.id) { error in
            if let error = error {
                print("신청서 제출 후 유저 업데이트 실패: ", error.localizedDescription)
            } else {
                UserService.getUser(userId: UserViewModel.shared.currentUser.id) { result in
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
    
    func deleteApplication(study: Study, completion: @escaping () -> Void) {
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
        }
        
        StudyService.deleteApplicationId(studyId: study.id, applicationId: applicationId) { error in
            if error != nil {
                print("신청서 삭제 후 스터디 업데이트 실패")
            } else {
                completion()
            }
        }
        
        UserService.deleteApplicationId(userId: UserViewModel.shared.currentUser.id, applicationId: applicationId) { error in
            if error != nil {
                print("신청서 삭제 후 유저 업데이트 실패")
            } else {
                UserService.getUser(userId: UserViewModel.shared.currentUser.id) { result in
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
    
    func getStudyApplication(study: Study) {
        ApplicationService.getStudyAllApplications(study: study) { result in
            switch result {
            case .success(let applications):
                self.applications = applications
                print("getStudyApplication 후 -----", applications)
            case .failure(let error):
                print("신청서 가져오기 실패", error.localizedDescription)
            }
        }
    }
    
    // 가입 승인
    func approveJoin(study: Study, completion: @escaping () -> Void) {
        var application = selectedApplication
        application.status = .approved
        
        let user = selectedApplication.user
        let position = selectedApplication.position
        let newMember = Member(user: user, position: position)
        var updatedStduy = study
        updatedStduy.currentMembers.append(newMember)
        updatedStduy.submittedApplications.removeAll(where: { $0 == selectedApplication.id })
        
        ApplicationService.updateApplication(application: application) { error in
            if let error = error {
                print("가입 승인 실패", error.localizedDescription)
            } else {
                print("가입 승인 성공")
            }
        }

        StudyService.updateStudy(study: updatedStduy) { error in
            if let error = error {
                print("가입 승인 스터디 업데이트 실패", error.localizedDescription)
            } else {
                print("가입 승인 스터디 업데이트 성공")
                completion()
            }
        }
    }
    
    // 가입 거절
    func rejectJoin(study: Study, completion: @escaping () -> Void) {
        var application = selectedApplication
        application.status = .rejected
        
        var updatedStduy = study
        updatedStduy.submittedApplications.removeAll(where: { $0 == application.id })
        
        ApplicationService.updateApplication(application: application) { error in
            if let error = error {
                print("가입 거절 실패", error.localizedDescription)
            } else {
                print("가입 거절 성공")
            }
        }

        StudyService.updateStudy(study: updatedStduy) { error in
            if let error = error {
                print("가입 거절 스터디 업데이트 실패", error.localizedDescription)
            } else {
                print("가입 거절 스터디 업데이트 성공")
                completion()
            }
        }
    }
    
    func resetSubmitApplication() {
        title = ""
        position = nil
        introduction = ""
        experience = ""
    }
}
