//
//  ApplicationViewModel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/29.
//

import SwiftUI
import Combine

class ApplicationViewModel: ObservableObject {
    
    var application = Application(
        user: User(id: "1", name: "김민수", email: "a@gmail.com", username: "민수민수"),
        title: "백엔드 지원합니다.",
        field: .backend,
        introduction: "안녕하세요",
        experience: "없습니다."
    )
}
