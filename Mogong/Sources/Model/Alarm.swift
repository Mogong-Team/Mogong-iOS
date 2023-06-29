//
//  Alarm.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/28.
//

import Foundation

enum AlarmType: CaseIterable {
    case chat
    case studyJoin
    case studyApplication
    
    var title: String {
        switch self {
        case .chat:
            return "채팅 알림"
        case .studyJoin:
            return "스터디 가입 완료 알림"
        case .studyApplication:
            return "스터디 신청 완료 알림"
        }
    }
    
    var message: String {
        switch self {
        case .chat:
            return "새로운 채팅 메시지가 도착했습니다."
        case .studyJoin:
            return "스터디 가입이 완료되었습니다. 축하합니다!"
        case .studyApplication:
            return "스터디 신청이 정상적으로 완료되었습니다."
        }
    }
    
    var imageString: String {
        switch self {
        case .chat:
            return "bubble.right.fill"
        case .studyJoin:
            return "crown.fill"
        case .studyApplication:
            return "checkmark.circle.fill"
        }
    }
}
