//
//  HashtagView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/26.
//

import SwiftUI

struct HashtagView: View {
    var text: String
    
    var body: some View {
        VStack {
            Text(text)
                .font(Font.system(size: 10, weight: .bold))
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(.purple)
                .cornerRadius(10)
        }
    }
}
