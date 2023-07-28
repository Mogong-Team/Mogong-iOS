//
//  Color.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/28.
//

import SwiftUI

extension Color {
    static let main = Color("main")
    static let member = Color("member")
}

fileprivate struct ColorTestView: View {
    
    let colors = [
        Color.main,
        Color.member,
    ]
    
    var body: some View {
        VStack {
            ForEach(colors, id: \.self) { color in
                Rectangle()
                    .foregroundColor(color)
                    .frame(width: .infinity, height: 50)
            }
        }
        .padding(20)
    }
}

struct ColorTestView_Previews: PreviewProvider {
    static var previews: some View {
        ColorTestView()
    }
}
