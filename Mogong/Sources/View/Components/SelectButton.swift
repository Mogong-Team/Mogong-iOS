//
//  SelectButton.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/26.
//

import SwiftUI

struct SelectButton: View {
    enum State {
        case selected
        case unselected
    }
    
    private let title: String
    private let state: State
    private let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                if state == .unselected {
                    Color.white
                    
                    Text(title)
                        .font(.pretendard(weight: .medium, size: 16))
                        .foregroundColor(Color(red: 0.7, green: 0.7, blue: 0.7))
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .overlay(
                        RoundedRectangle(cornerRadius: 9)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.86, green: 0.96, blue: 0.99), lineWidth: 1)
                        )
                    
                    
                } else {
                    Color(red: 0, green: 0.78, blue: 0.96)
                    
                    Text(title)
                        .font(.pretendard(weight: .medium, size: 16))
                        .foregroundColor(.white)
                }
            }
            .frame(height: 42)
            .cornerRadius(9)
        }
    }
    
    init(title: String, state: State, action: @escaping () -> Void) {
        self.title = title
        self.state = state
        self.action = action
    }
}
