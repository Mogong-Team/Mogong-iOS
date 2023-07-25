//
//  Member.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/24.
//

import Foundation

struct Member2: Hashable, Codable {
    let user: User
    let position: Position2
}

extension Member2 {
    static var member1 = Member2(user: User.user1, position: .backend)
}
