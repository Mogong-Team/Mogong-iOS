//
//  1.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/06.
//

import SwiftUI

struct VStackNewTeamMemberView: View {
    var position: Position2
    
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .scaledToFit()
                    .clipShape(Circle())
                    .foregroundColor(.yellow)
                
                Text("New!")
                    .font(.pretendard(weight: .bold, size: 15))
            }
            
            Text("모집중!")
                .font(Font.system(size: 20, weight: .bold))
                .foregroundColor(.black)
            
            Text(position.rawValue)
                .font(Font.system(size: 14, weight: .regular))
                .foregroundColor(.gray)
        }
    }
}

struct VStackNewTeamMemberView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VStackNewTeamMemberView(position: .backend)
            VStackNewTeamMemberView(position: .ios)
        }
    }
}
