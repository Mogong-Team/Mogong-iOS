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
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 5) {
                Text("스크랩이 많은 스터디")
                    .font(.pretendard(weight: .bold, size: 18))

                Text("관심 집중 스터디에요!")
                    .font(.pretendard(weight: .medium, size: 14))
                    .foregroundColor(.gray)
            }

            ScrollView() {
                VStack {
                    ForEach(viewModel.studys) { study in
                        ClippyStudyCell(study: study)
                            .padding(5)
                    }
                }
            }
        }
    }
}

struct ClippyStudyView_Previews: PreviewProvider {
    static var previews: some View {
        ClippyStudyView()
            .environmentObject(StudyViewModel())
    }
}
