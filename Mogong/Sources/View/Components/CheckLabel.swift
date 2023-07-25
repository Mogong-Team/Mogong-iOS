//
//  CheckLabel.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/29.
//

import SwiftUI

struct CheckLabel: View {
    var text: String
    var isHighlighted: Bool
    
    var body: some View {
        VStack {
            Label {
                Text(text)
                    .font(.pretendard(weight: .bold, size: 12))
                    .foregroundColor(isHighlighted
                                     ? .black
                                     : Color(hexColor: "7C7979"))
            } icon: {
                Image("vector")
                    .foregroundColor(Color(hexColor: "76C5FF"))
            }
        }
    }
}
