//
//  MemberVstack.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/25.
//

import SwiftUI

struct MemberVstack: View {
    var member: Member2
    var isHost: Bool
    
    var body: some View {
        VStack {
            ZStack {
                ZStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 92, height: 92)
                        .scaledToFit()
                        .clipShape(Circle())
                        .foregroundColor(Color(hexColor: "8FC7FB"))
                    
                    if isHost {
                        Image(systemName: "bookmark.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(.white, Color(hexColor: "00A2FF"))
                            .padding(.leading, -50)
                            .padding(.top, -50)
                    }
                }
            }
            
            VStack{
                Text(member.user.username)
                    .font(.pretendard(weight: .semiBold, size: 20))
                    .foregroundColor(Color(hexColor: "1C1B1B", opacity: 0.7))
                
                Text("프론트엔드")
                    .font(Font.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
            }
        }
    }
}

struct MemberVstack_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MemberVstack(member: Member2.member1, isHost: true)
            MemberVstack(member: Member2.member1, isHost: false)
        }
    }
}
