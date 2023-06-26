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
}
