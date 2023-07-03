//
//  UserViewModel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    var currentUser = User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수")
}
