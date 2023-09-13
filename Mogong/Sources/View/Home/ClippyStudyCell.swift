//
//  ClippyStudyCell.swift
//  Mogong
//
//  Created by 예강이다 on 2023/07/08.
//

import SwiftUI
import KakaoSDKCommon

struct ClippyStudyCell: View {
    var study: Study
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(study.state.rawValue)
                    .font(.pretendard(weight: .bold, size: 12))
                    .foregroundColor(.white)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 3)
                    .background(study.state == .completed
                                ? Color(hexColor: "C5C5C5")
                                : Color(hexColor: "FFB800"))
                    .cornerRadius(8)
                
                // 북마크
                HStack(spacing: 2) {
                    Image(systemName: "bookmark.fill")
                        .foregroundColor(Color.main)
                    
                    Text("\(study.bookMarkedUsers.count)")
                        .font(.pretendard(weight: .bold, size: 16))
                        .foregroundColor(Color.main)
                }
                Spacer()
                Image(systemName: "chevron.forward")
                    .foregroundColor(Color.gray)
            }
            
            HStack {
                Text(study.title)
                    .font(.pretendard(weight: .bold, size: 16))
                    .foregroundColor(Color(hexColor: "3E3D3D"))
                    .lineLimit(1)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 14)
        .background(.white)
        .cornerRadius(17)
        .overlay(
            RoundedRectangle(cornerRadius: 17)
                .inset(by: 0.5)
                .stroke(Color(hexColor: "F1F1F1"), lineWidth: 1)
        )
        .shadow(color: Color(white: 0, opacity: 0.1), radius: 5, x: 5, y: 5)
    }
}

struct ClippyStudyCell_Previews: PreviewProvider {
    static var previews: some View {
        ClippyStudyCell(study: Study.study1)
    }
}
