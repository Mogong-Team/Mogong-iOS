//
//  Position.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/24.
//

import Foundation

enum Position: String, CaseIterable, Hashable, Codable {
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
            return [.python, .java, .nestjs, .mogodb, .php, .nodejs, .spring, .mysql, .django]
        case .frontend:
            return [.javaScript, .typescript, .react, .nextjs, .vue, .svelte, .vue]
        case .ios:
            return [.swift]
        case .aos:
            return [.kotlin]
        case .cross:
            return [.flutter, .reactNative]
        case .designer:
            return [.figma]
        case .planner:
            return []
        }
    }
}

struct PositionInfo: Hashable, Codable {
    var position: Position
    var requiredCount: Int = 0
    var language: [Language] = []
}

enum GeneralStudyCategory: String, CaseIterable, Hashable, Codable {
    case backend = "백엔드"
    case frontend = "프론트엔드"
    case mobile = "모바일"
    case etc = "기타"
    
    var language: [Language] {
        switch self {
        case .backend:
            return [.python, .java, .nestjs, .mogodb, .php, .nodejs, .spring, .mysql, .django]
        case .frontend:
            return [.javaScript, .typescript, .react, .nextjs, .vue, .svelte]
        case .mobile:
            return [.swift, .kotlin, .flutter, .reactNative]
        case .etc:
            return [.figma]
        }
    }
}
