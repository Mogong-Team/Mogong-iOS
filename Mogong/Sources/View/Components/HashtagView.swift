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
            Text("#\(text)")
                .font(.pretendard(weight: .bold, size: 16))
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(Color(hexColor: "00C7F4"))
                .cornerRadius(16)
        }
    }
}

struct HashtagView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HashtagView(text: "Swift")
            HashtagView(text: "Java")
        }
    }
}
