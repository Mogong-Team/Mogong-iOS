//
//  CheckLabel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/29.
//

import SwiftUI

struct CheckLabel: View {
    var text: String
    
    var body: some View {
        VStack {
            Label {
                Text(text)
                    .font(.pretendard(weight: .bold, size: 12))
                    .foregroundColor(.gray)
            } icon: {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
            }
        }
    }
}
