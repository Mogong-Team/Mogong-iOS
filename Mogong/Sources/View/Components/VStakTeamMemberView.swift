//
//  VStakTeamMemberView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/06.
//

import SwiftUI

struct VStakTeamMemberView: View {
    var member: Member
    
    var viewType: HostMemberType
    
    @State var showDropAlert: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .scaledToFit()
                .clipShape(Circle())
                .foregroundColor(.gray)
            
            Text(member.user.username)
                .font(Font.system(size: 20, weight: .bold))
                .foregroundColor(.black)
            
            Text(member.position.rawValue)
                .font(Font.system(size: 14, weight: .regular))
                .foregroundColor(.gray)
            
            if viewType == .host {
                Button {
                    showDropAlert = true
                } label: {
                    ZStack {
                        Color.red
                        
                        Text("강퇴하기")
                            .font(.pretendard(weight: .regular, size: 16))
                            .foregroundColor(.white)
                    }
                    .frame(height: 25)
                    .cornerRadius(11)
                }
                .alert("강퇴하기", isPresented: $showDropAlert) {
                    Button("확인", role: .destructive) {
                        // 강퇴하기
                    }
                    
                    Button("취소", role: .cancel) { }
                } message: {
                    Text("정말로 강퇴하시겠습니까?")
                }
            }
        }
    }
}

struct VStakTeamMemberView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VStakTeamMemberView(member: Member.member1, viewType: .host)
            VStakTeamMemberView(member: Member.member1, viewType: .member)
        }
    }
}
