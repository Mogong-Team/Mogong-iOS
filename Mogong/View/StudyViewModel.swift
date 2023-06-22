//
//  StudyViewModel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI
import Combine

class StudyViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    
    var tags = ["모집중", "모집완료", "스터디완주 2회", "#자바스크립트", "#앱개발", "#디자이너"]
    var des = ["줌 스터디", "참여인원 10명", "대규모 프로젝트", "화이팅"]
}
