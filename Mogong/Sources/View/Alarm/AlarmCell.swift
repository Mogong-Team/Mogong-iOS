//
//  AlarmCell.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/28.
//

import SwiftUI

struct AlarmCell: View {
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .scaledToFit()
                .foregroundColor(.green)
            
            VStack(alignment: .leading) {
                Text("스터디 지원 완료")
                    .font(Font.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                
                Text("스터디에 지원이 완료되었습니다.")
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack {
                Text("안읽음")
                
                Spacer()
            }
        }
    }
}
