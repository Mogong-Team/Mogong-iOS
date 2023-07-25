//
//  Position.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/24.
//

import Foundation

enum Position2: String, CaseIterable {
    case backend = "백엔드"
    case frontend = "프론트엔드"
    case ios = "iOS"
    case aos = "AOS"
    case cross = "크로스 플랫폼"
    case designer = "디자이너"
    case planner = "기획"
    
    var language: [Language] {
        switch self {
        case .backend:
            return [.python, .ruby, .go, .rust, .php, .nodejs, .spring, .django]
        case .frontend:
            return [.javaScript, .typescript, .react, .angular, .vue, .html, .css]
        case .ios:
            return [.swift]
        case .aos:
            return [.kotlin]
        case .cross:
            return [.flutter, .reactNative]
        case .designer:
            return [.figma, .photoshop]
        case .planner:
            return []
        }
    }
}

struct PositionInfo: Hashable {
    var position: Position2
    var requiredCount: Int = 0
    var currentCount: Int = 0
    var language: [Language] = []
}
