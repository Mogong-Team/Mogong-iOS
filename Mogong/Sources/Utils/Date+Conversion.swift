//
//  Date+Conversion.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter.string(from: self)
    }
    
    func toMessageString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일 a h:mm"
        return formatter.string(from: self)
    }
    
    func toChatString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일 a h:mm"
        return formatter.string(from: self)
    }
    
    func relativeTime() -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .day], from: self , to: Date())
        let hour = components.hour ?? 0
        let day = components.day ?? 0
        
        if day > 6 {
            let weeks = day / 7
            return "\(weeks)주 전"
        } else if day <= 6 && day > 0 {
            return "\(day)일 전"
        } else if hour < 24 && hour > 1 {
            return "\(hour)시간 전"
        } else {
            return "방금 전"
        }
    }
    
    func dDayString() -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: .now, to: self)
        
        guard let day = components.day else { return "" }
        
        if day > 0 {
            return "D-\(day)"
        } else if day < 0 {
            return "D+\(-day)"
        } else {
            return "D-day"
        }
    }
}
