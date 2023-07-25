//
//  ClippyStudyCell.swift
//  Mogong
//
//  Created by 예강이다 on 2023/07/08.
//

import SwiftUI

struct ClippyStudyCell: View {
    
    // 필요한 데이터
    // 모집상태(모집중, 모집완료(Bool))
    // 북마크 횟수(Int)
    // 스터디 제목(String)
    
//    let clippyStudy: Clippy

//    // 모집상태
//    var isRecruitmentState = false
//    // 스터디 완료
//    var istStudyCompleted = false
    
    var study: Study
    
    var body: some View {
        NavigationLink {
            // 선택한 스터디에 맞는 뷰로 이동하는 코드
        } label: {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(study.state.rawValue)
                        .foregroundColor(.white)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 3)
                        .background(study.state == .completed
                                    ? Color.gray
                                    : Color.yellow)
                        .cornerRadius(5)
                    
                    // 북마크 색상은 고정
                    HStack {
                        Image(systemName: "bookmark.fill")
                            .foregroundColor(.blue)
                        Text("1000")
                    }
                    Spacer()
                    Image(systemName: "chevron.forward")
                }
                
                HStack {
                    Text(study.title)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .frame(alignment: .leading)
                }
            }
            .padding(10)
            .foregroundColor(.clear)
            .frame(width: 360, height: 80, alignment: .leading)
            .background(Color(uiColor: .white))
            .cornerRadius(15)
            .shadow(color: .gray, radius: 2.5, x: 4, y: 4)
        }
    }
}

struct ClippyStudyCell_Previews: PreviewProvider {
    static var previews: some View {
        ClippyStudyCell(study: Study.study1)
    }
}
