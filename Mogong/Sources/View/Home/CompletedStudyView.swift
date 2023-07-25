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
        VStack(alignment: .leading, spacing: 12) {
            Text("방금 완주한 스터디")
                .font(.system(size: 20))
                .fontWeight(.bold)
            
            Text("방금 완주한 따끈따끈한 스터디 목록을 살펴보세요!")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(viewModel.studys) { study in
                        CompletedStudyCell(study: study)
                            .frame(width: 140, height: 200)
                    }
                }
            }
        }
        .frame(width: 380)
        .padding()
    }
}

struct CompletedStudyView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedStudyView()
            .environmentObject(StudyViewModel())
    }
}
