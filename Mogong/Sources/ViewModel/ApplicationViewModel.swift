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
    
    @Published var application =
    Application(
        user: User.user1,
        title: "backend 지원합니다.",
        position: .backend,
        introduction: "안녕하세요",
        experience: "없습니다.")
    
    @Published var applications = [
        Application(
            user: User.user1,
            title: "backend 지원합니다.",
            position: .backend,
            introduction: "안녕하세요",
            experience: "없습니다."),
        
        Application(
            user: User.user2,
            title: "designer 지원합니다.",
            position: .designer,
            introduction: "안녕하세요",
            experience: "없습니다."),
        
        Application(
            user: User.user3,
            title: "frontend 지원합니다.",
            position: .frontend,
            introduction: "안녕하세요",
            experience: "없습니다."),
        
        Application(
            user: User.user4,
            title: "ios 지원합니다.",
            position: .ios,
            introduction: "안녕하세요",
            experience: "없습니다."),
        
        Application(
            user: User.user5,
            title: "aos 지원합니다.",
            position: .aos,
            introduction: "안녕하세요",
            experience: "없습니다."),
    ]
    
    var cancellables = Set<AnyCancellable>()
    
    func fetchApplications(user: User) {
        applicationService.fetchApplications { [weak self] result in
            switch result {
            case .success(let applications):
                DispatchQueue.main.async {
                    self?.applications = applications.filter { $0.user.id == user.id }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // 신청서 승인
    func approveApplication(index: Int) {
        applications[index].status = .approved
    }
    
    // 신청서 거절
    func rejectApplication(index: Int) {
        applications[index].status = .rejected
    }
}
