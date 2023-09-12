//
//  CompletedStudyCell.swift
//  Mogong
//
//  Created by 예강이다 on 2023/07/08.
//

import SwiftUI

struct CompletedStudyCell: View {
    var study: Study
    var image: Image
    
    var body: some View {
        ZStack {
            image
                .resizable()
            
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                
                Text(study.title)
                    .foregroundColor(Color(hexColor: "4B4B4B"))
                    .font(.pretendard(weight: .bold, size: 14))
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .padding(10)
            }
        }
        .frame(width: 130, height: 185)
        .cornerRadius(15)
        .shadow(color: Color(white: 0, opacity: 0.3), radius: 5, x: 5, y: 5)
    }
}

struct CompletedStudyCell_Previews: PreviewProvider {
    static var previews: some View {
        CompletedStudyCell(study: Study.study1, image: Image("CharacterCard1"))
    }
}
