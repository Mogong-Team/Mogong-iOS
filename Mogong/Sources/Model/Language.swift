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
    case java = "Java"
    case python = "Python"
    case spring = "Spring"
    case php = "PHP"
    case nodejs = "Node.js"
    case django = "Django"
    case mysql = "MySQL"
    case nestjs = "Nestjs"
    case mogodb = "MogoDB"
    
    // 프론트엔드
    case javaScript = "JavaScript"
    case typescript = "TypeScript"
    case react = "React"
    case vue = "Vue"
    case nextjs = "Next.js"
    case svelte = "Svelte"

    // 디자이너
    case figma = "Figma"
    
    var imageString: String {
        switch self {
        case .swift: return "swift"
        case .kotlin: return "kotlin"
        case .flutter: return "flutter"
        case .reactNative: return "reactnative"
        case .python: return "python"
        case .php: return "php"
        case .nodejs: return "nodejs"
        case .spring: return "spring"
        case .django: return "django"
        case .javaScript: return "javascript"
        case .typescript: return "typescript"
        case .react: return "react"
        case .nextjs: return "nextjs"
        case .vue: return "vue"
        case .figma: return "figma"
        case .java: return "java"
        case .mysql: return "mysql"
        case .nestjs: return "nestjs"
        case .mogodb: return "mogodb"
        case .svelte: return "svelte"
        }
    }
}
