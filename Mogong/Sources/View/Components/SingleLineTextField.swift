//
//  SingleLineTextField.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/26.
//

import SwiftUI

struct SingleLineTextField: View {
    @Binding var text: String
    var placeHolder: String
    
    var body: some View {
        VStack {
            TextField(placeHolder, text: $text)
                .font(.pretendard(weight: .medium, size: 14))
                .padding(.horizontal, 13)
                .frame(height: 38)
                .overlay {
                    Rectangle()
                        .foregroundColor(.clear)
                        .overlay(
                        RoundedRectangle(cornerRadius: 9)
                        .inset(by: 0.5)
                        .stroke(Color(red: 0.86, green: 0.96, blue: 0.99), lineWidth: 1)
                        )
                }
        }
    }
}

