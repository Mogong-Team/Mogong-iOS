//
//  Language.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/26.
//

import Foundation

enum Language: String, CaseIterable, Codable {
    // iOS
    case swift = "Swift"
    
    // AOS
    case kotlin = "Kotlin"
    
    // 크로스 플랫폼
    case flutter = "Flutter"
    case reactNative = "React Native"
    
    // 백엔드
    case python = "Python"
    case ruby = "Ruby"
    case go = "Go"
    case rust = "Rust"
    case php = "PHP"
    case nodejs = "Node.js"
    case spring = "Spring"
    case django = "Django"
    
    // 프론트엔드
    case javaScript = "JavaScript"
    case typescript = "TypeScript"
    case react = "React"
    case angular = "Angular"
    case vue = "Vue"
    case html = "HTML"
    case css = "CSS"
    
    // 디자이너
    case figma = "Figma"
    case photoshop = "Photoshop"
    
    var imageString: String {
        switch self {
        case .swift: return ""
        case .kotlin: return ""
        case .flutter: return ""
        case .reactNative: return ""
        case .python: return ""
        case .ruby: return ""
        case .go: return ""
        case .rust: return ""
        case .php: return ""
        case .nodejs: return ""
        case .spring: return ""
        case .django: return ""
        case .javaScript: return ""
        case .typescript: return ""
        case .react: return ""
        case .angular: return ""
        case .vue: return ""
        case .html: return ""
        case .css: return ""
        case .figma: return ""
        case .photoshop: return ""
        }
    }
}
