//
//  MemberIntroductionView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/26.
//

import SwiftUI

struct MemberIntroductionView: View {
    var username: String
    
    var body: some View {
        VStack {
            Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .clipShape(Circle())
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .frame(width: 50, height: 20)
                    .foregroundColor(.gray)
                
                Text("Level 1")
                    .font(Font.system(size: 14))
                    .foregroundColor(.white)
            }
            
            Text(username)
                .font(Font.system(size: 20))
        }
        .frame(width: 130, height: 170)
    }
}

struct MemberIntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        MemberIntroductionView(username: "김민수")
    }
}
