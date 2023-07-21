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
        VStack(alignment: .leading) {
            Text("스크랩이 많은 스터디")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("관심 집중 스터디에요!")
                .font(.subheadline)
                .foregroundColor(.gray)

            ScrollView() {
                VStack(spacing: 16) {
                    ForEach(viewModel.studys) { study in
                        ClippyStudyCell(study: study)
                    }
                }
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
