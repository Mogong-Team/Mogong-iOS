//
//  CompletedStudyView.swift
//  Mogong
//
//  Created by 예강이다 on 2023/07/08.
//

import SwiftUI

struct CompletedStudyView: View {
    @EnvironmentObject var viewModel: StudyViewModel
//    @State private var imgNumber: Int = 1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                Text("방금 완주한 스터디")
                    .font(.pretendard(weight: .bold, size: 20))
                
                Text("방금 완주한 따끈따끈한 스터디 목록을 살펴보세요!")
                    .font(.pretendard(weight: .medium, size: 14))
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 10)
            .padding(.horizontal, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(Array(viewModel.studys.enumerated()), id: \.element.id) { index, study in
//                        let study = viewModel.studys[index]
                        let image = Image("CharacterCard\((index % 6) + 1)")
                        
                        CompletedStudyCell(study: study, image: image)
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
            }
        }
    }
}

struct CompletedStudyView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedStudyView()
            .environmentObject(StudyViewModel())
    }
}
