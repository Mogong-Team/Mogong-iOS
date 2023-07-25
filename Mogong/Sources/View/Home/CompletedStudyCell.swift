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
            StudyListView()
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .bottom) {
                    ZStack {
                        Image(systemName: "pencil")
                            .resizable()
                        
                        VStack() {
                            Spacer()
                            Text(study.title)
                                .foregroundColor(.black)
                                .fontWeight(.bold)
                                .lineLimit(3)
                                .padding(10)
                        }
                    }
                }
            }
            .frame(width: 130, height: 185, alignment: .leading)
            .background(Color(uiColor: .white))
            .cornerRadius(15)
            .shadow(color: .gray, radius: 5, x: 2, y: 2)
        }
    }
}

struct CompletedStudyCell_Previews: PreviewProvider {
    static var previews: some View {
        CompletedStudyCell(study: Study.study1)
    }
}
