//
//  Member.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/24.
//

import Foundation

struct Member: Hashable, Codable {
    let user: User
    let position: Position
}

extension Member {
    static var member1 = Member(user: User.user1, position: .backend)
}
