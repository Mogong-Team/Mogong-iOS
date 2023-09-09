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
                        .foregroundColor(Color(hexColor: "B3B3B3"))
                } else {
                    Color.main
                    
                    Text(title)
                        .font(Font.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                }
            }
            .frame(height: 45)
            .cornerRadius(9)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(hexColor: "DBF6FC"), lineWidth: 1)
            }
        }
    }
    
    init(title: String, state: State, action: @escaping () -> Void) {
        self.title = title
        self.state = state
        self.action = action
    }
}

struct SelectButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SelectButton(title: "버튼", state: .selected) { }
            SelectButton(title: "버튼", state: .unselected) { }
        }
        .padding(.horizontal, 20)
    }
}
