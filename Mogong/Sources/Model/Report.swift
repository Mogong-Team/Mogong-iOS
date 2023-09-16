//
//  Report.swift
//  Mogong
//
//  Created by 심현석 on 2023/09/16.
//

import Foundation

enum BadReport: CaseIterable {
    case dontLike
    case spam
    case hateSpeech
    case violenceOrDangerousGroup
    case falseInformation
    case fraudOrScam
    
    var title: String {
        switch self {
        case .dontLike:
            return "마음에 들지 않습니다"
        case .spam:
            return "스팸"
        case .hateSpeech:
            return "혐오 발언 또는 상징"
        case .violenceOrDangerousGroup:
            return "폭력 또는 위험한 단체"
        case .falseInformation:
            return "거짓 정보"
        case .fraudOrScam:
            return "사기 또는 거짓"
        }
    }
}



