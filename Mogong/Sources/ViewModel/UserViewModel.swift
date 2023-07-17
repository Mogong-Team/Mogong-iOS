//
//  UserViewModel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    //@Published var currentUser: User
    var currentUser = User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수")

    func currentUserIsHost(study: Study) -> Bool {
        return study.host.user.id == currentUser.id
    }
    
    func currentUserIsHost(member: Member) -> Bool {
        return member.user.id == currentUser.id
    }
    
    // 스터디 스크랩
    func bookmarkStudy(_ study: Study) {
        // TODO: 실제로 스터디를 스크랩하는 로직을 여기에 작성합니다.
        currentUser.bookmarkedStudyIds.append(study.id)
    }
    
    // 스터디 스크랩 취소
    func removeBookmark(for study: Study) {
        // TODO: 실제로 스터디 스크랩을 취소하는 로직을 여기에 작성합니다.
        currentUser.bookmarkedStudyIds.removeAll(where: { $0 == study.id })
    }
}
