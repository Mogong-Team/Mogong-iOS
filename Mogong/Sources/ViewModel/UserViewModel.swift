//
//  UserViewModel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    @Published var currentUser: User = User.user1
    
    static let shared = UserViewModel()

    func currentUserIsHost(study: Study) -> Bool {
        return study.host.id == currentUser.id
    }
    
    func getUserInfo() {
        // TODO: get User
    }
    
    func updateUserInfo() {
        // TODO: POST User
    }
    
    func bookmarkStudy(_ study: Study) {
        // TODO: 실제로 스터디를 스크랩하는 로직을 여기에 작성합니다.
        currentUser.bookmarkedStudyIds.append(study.id)
    }
    
    func removeBookmark(for study: Study) {
        // TODO: 실제로 스터디 스크랩을 취소하는 로직을 여기에 작성합니다.
        currentUser.bookmarkedStudyIds.removeAll(where: { $0 == study.id })
    }
}
