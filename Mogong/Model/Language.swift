//
//  Language.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/26.
//

import Foundation

enum Language: String, CaseIterable {
    // 디자이너
    case figma = "Figma"
    case photoshop = "Photoshop"

    // iOS
    case swift = "Swift"

    // AOS
    case kotlin = "Kotlin"
    
    // iOS / AOS
    case flutter = "Flutter"
    case reactNative = "React Native"

    // Backend
    case python = "Python"
    case ruby = "Ruby"
    case go = "Go"
    case rust = "Rust"
    case php = "PHP"
    case nodejs = "Node.js"
    case spring = "Spring"
    case django = "Django"

    // Frontend
    case javaScript = "JavaScript"
    case typescript = "TypeScript"
    case react = "React"
    case angular = "Angular"
    case vue = "Vue"
    case html = "HTML"
    case css = "CSS"

    // 공통
    case java = "Java"
    case cPlusPlus = "C++"
    case cSharp = "C#"
    case sql = "SQL"
}
