//
//  Date+Conversion.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI

extension Date {
    func toDotString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: self)
    }
    
    func toYearString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter.string(from: self)
    }
    
    func toMonthString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일"
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
