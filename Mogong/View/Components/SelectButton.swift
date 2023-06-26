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
                    Color.gray
                    
                    Text(title)
                        .font(Font.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                } else {
                    Color.blue
                    
                    Text(title)
                        .font(Font.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                }
            }
            .frame(height: 42)
            .cornerRadius(12)
        }
    }
    
    init(title: String, state: State, action: @escaping () -> Void) {
        self.title = title
        self.state = state
        self.action = action
    }
}
