//
//  CompletedStudyView.swift
//  Mogong
//
//  Created by 예강이다 on 2023/07/08.
//

import SwiftUI

struct CompletedStudyView: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            VStack(alignment: .leading, spacing: 5) {
                Text("방금 생성된 스터디")
                    .font(.pretendard(weight: .bold, size: 20))
                
                Text("방금 생성된 따끈따끈한 스터디 목록을 살펴보세요!")
                    .font(.pretendard(weight: .medium, size: 14))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 20)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(Array(viewModel.allStudys.enumerated()), id: \.element.id) { index, study in
                        let image = Image("CharacterCard\((index % 6) + 1)")
                        
                        CompletedStudyCell(study: study, image: image)
                            .onTapGesture {
                                viewModel.showStudyDetailOnHomeNew = true
                                viewModel.selectedStudy = study
                            }
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 20)
                .padding(.horizontal, 15)
            }
        }
        .fullScreenCover(isPresented: $viewModel.showStudyDetailOnHomeNew, onDismiss: {
            viewModel.getAllStudys()
        }) {
            NavigationStack {
                StudyDetailView()
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
