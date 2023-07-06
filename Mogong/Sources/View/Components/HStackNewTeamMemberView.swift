//
//  HStackNewTeamMemberView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/06.
//

import SwiftUI

struct HStackNewTeamMemberView: View {
    var field: Field
    
    var body: some View {
        HStack {
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
            
            VStack(alignment: .leading) {
                Text("모집중!")
                    .font(Font.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                
                Text(field.rawValue)
                    .font(Font.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
            }
        }
    }
}
