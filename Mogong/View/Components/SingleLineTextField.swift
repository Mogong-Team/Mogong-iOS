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
                .font(.body)
                .padding(.horizontal, 13)
                .frame(height: 38)
                .overlay {
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(Color.gray, lineWidth: 1)
                }
        }
    }
}

