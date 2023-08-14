//
//  ApplicationViewModel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/29.
//

import SwiftUI
import Combine

class ApplicationViewModel: ObservableObject {
    
    let applicationService = ApplicationService.shared
    var cancellables = Set<AnyCancellable>()
    
    @Published var title: String = ""
    @Published var position: Position?
    @Published var introduction: String = ""
    @Published var experience: String = ""
    
    func fetchApplications(user: User) {
        applicationService.fetchApplications { result in
            switch result {
            case .success(let applications):
                DispatchQueue.main.async {
                    Application.applications = applications.filter { $0.user.id == user.id }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // 신청서 승인
    func approveApplication(index: Int) {
        Application.applications[index].status = .approved
    }
    
    // 신청서 거절
    func rejectApplication(index: Int) {
        Application.applications[index].status = .rejected
    }
    
    func resetAll() {
        title = ""
        position = nil
        introduction = ""
        experience = ""
    }
}
