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
                        .font(Font.system(size: 18, weight: .medium))
                        .foregroundColor(.gray)
                } else {
                    Color.blue
                    
                    Text(title)
                        .font(Font.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                }
            }
            .frame(height: 42)
            .cornerRadius(12)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            }
        }
    }
    
    init(title: String, state: State, action: @escaping () -> Void) {
        self.title = title
        self.state = state
        self.action = action
    }
}
