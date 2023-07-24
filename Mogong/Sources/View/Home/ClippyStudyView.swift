//
//  ClippyStudyView.swift
//  Mogong
//
//  Created by 예강이다 on 2023/07/08.
//

import SwiftUI

struct ClippyStudyView: View {
    @EnvironmentObject var viewModel: StudyViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 18) {
                Text("스크랩이 많은 스터디")
                    .font(Font.custom("Pretendard", size: 20))
                    .fontWeight(.bold)

                Text("관심 집중 스터디에요!")
                    .font(Font.custom("Sintory", size: 14))
                    .foregroundColor(.gray)
            }

            ScrollView() {
                VStack {
                    ForEach(viewModel.studys) { study in
                        ClippyStudyCell(study: study)
                            .padding(2)
                    }
                }
                .frame(width: 380)
            }
        }
        
        .padding()
    }
}

struct ClippyStudyView_Previews: PreviewProvider {
    static var previews: some View {
        ClippyStudyView()
            .environmentObject(StudyViewModel())
    }
}
