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
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    ZStack {
                        Image("CharacterCard1")
                            .resizable()
                        
                        VStack() {
                            Text(study.title)
                                .foregroundColor(.black)
                                .font(.pretendard(weight: .bold, size: 14))
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                                .padding(.horizontal, 10)
                                .padding(.top, 100)
                        }
                    }
                }
            }
            .frame(width: 130, height: 185, alignment: .leading)
            .cornerRadius(15)
            .shadow(color: .gray, radius: 1, x: 1, y: 1)
        }
    }
}

struct CompletedStudyCell_Previews: PreviewProvider {
    static var previews: some View {
        CompletedStudyCell(study: Study.study1)
    }
}
