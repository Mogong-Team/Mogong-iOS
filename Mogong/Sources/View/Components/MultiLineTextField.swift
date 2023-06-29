//
//  MultiLineTextField.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/26.
//

import SwiftUI

struct MultiLineTextField: View {
    @Binding var text: String
    var placeHolder: String
    
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .font(.body)
                .padding(.horizontal, 13)
                .overlay(
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(Color.gray, lineWidth: 1)
                )
            .onAppear() {
                if text.isEmpty {
                    text = placeHolder
                }
            }
            .foregroundColor(text == placeHolder ? .gray : .primary)
            .onTapGesture {
                if text == placeHolder {
                    text = ""
                }
            }
        }
    }
}
