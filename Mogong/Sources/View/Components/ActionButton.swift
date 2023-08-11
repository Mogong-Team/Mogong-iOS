//
//  ActionButton.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/24.
//

import SwiftUI

struct ActionButton: View {
    @Environment(\.isEnabled) var isEnabled: Bool
    
    private let title: LocalizedStringKey
    private let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .buttonStyle(ActionButtonStyle(isEnabled: isEnabled))
    }

    init(_ title: LocalizedStringKey, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

struct ActionButtonStyle: ButtonStyle {
    let isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .font(.pretendard(weight: .regular, size: 18))
            .padding(.vertical, 11)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(isEnabled
                        ? Color.main
                        : Color(uiColor: .systemGray4))
            .cornerRadius(30)
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ActionButton("다음") {
            }
            .disabled(false)
            
            ActionButton("다음") {
            }
            .disabled(true)
        }
    }
}
