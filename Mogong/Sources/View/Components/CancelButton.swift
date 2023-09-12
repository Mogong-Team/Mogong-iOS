//
//  CancelButton.swift
//  Mogong
//
//  Created by 심현석 on 2023/09/11.
//

import SwiftUI

struct CancelButton: View {
    @Environment(\.isEnabled) var isEnabled: Bool
    
    private let title: LocalizedStringKey
    private let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .buttonStyle(CancelButtonButtonStyle(isEnabled: isEnabled))
    }

    init(_ title: LocalizedStringKey, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

struct CancelButtonButtonStyle: ButtonStyle {
    let isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .font(.pretendard(weight: .semiBold, size: 16))
            .padding(.vertical, 11)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(isEnabled
                        ? Color(hexColor: "FE6B61")
                        : Color(hexColor: "C5C5C5"))
            .cornerRadius(30)
    }
}

struct CancelButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CancelButton("취소") {
            }
            .disabled(false)
            
            CancelButton("취소") {
            }
            .disabled(true)
        }
    }
}
