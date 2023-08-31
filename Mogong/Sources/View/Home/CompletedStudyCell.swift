//
//  CompletedStudyCell.swift
//  Mogong
//
//  Created by 예강이다 on 2023/07/08.
//

import SwiftUI

struct CompletedStudyCell: View {
    var study: Study
    
    var body: some View {
        NavigationLink {
//            StudyListView()
        } label: {
            Text(study.title)
                .foregroundColor(Color(hexColor: "4B4B4B"))
                .font(.pretendard(weight: .bold, size: 14))
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .padding(.top, 100)
                .padding(.horizontal, 8)
            .frame(width: 130, height: 185)
            .background(
                Image("CharacterCard1")
            )
            .shadow(color: Color(white: 0, opacity: 0.1), radius: 5, x: 5, y: 5)
        }
    }
}

struct CompletedStudyCell_Previews: PreviewProvider {
    static var previews: some View {
        CompletedStudyCell(study: Study.study1)
    }
}
