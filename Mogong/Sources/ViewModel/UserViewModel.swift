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
}
