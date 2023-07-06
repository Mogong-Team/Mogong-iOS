//
//  HStakTeamMemberView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/06.
//

import SwiftUI

struct HStakTeamMemberView: View {
    var member: Member
    var isSelected: Bool
    
    var body: some View {
        HStack {
            ZStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .stroke(isSelected ? Color.red : Color.clear, lineWidth: 3)
                    }
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.red)
                        .padding(.leading, -30)
                        .padding(.top, -30)
                        .background(.gray)
                }
            }
            
            VStack(alignment: .leading) {
                Text(member.user.username)
                    .font(Font.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                
                Text("프론트엔드")
                    .font(Font.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
            }
        }
    }
}

struct HStakTeamMemberView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStakTeamMemberView(member: Member(user: User(id: "1", name: "김민수", email: "a@gmail.com", username: "민수민수"), field: .backend), isSelected: true)
            HStakTeamMemberView(member: Member(user: User(id: "1", name: "김민수", email: "a@gmail.com", username: "민수민수"), field: .backend), isSelected: false)
        }
        .environmentObject(ApplicationViewModel())
    }
}
