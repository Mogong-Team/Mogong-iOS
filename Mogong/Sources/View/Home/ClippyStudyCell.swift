//
//  ClippyStudyCell.swift
//  Mogong
//
//  Created by 예강이다 on 2023/07/08.
//

import SwiftUI
import KakaoSDKCommon

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
                        .font(.pretendard(weight: .bold, size: 16))
                        .foregroundColor(.white)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 3)
                        .background(study.state == .completed
                                    ? Color.gray
                                    : Color(red: 1, green: 0.72, blue: 0))
                        .cornerRadius(8)
                    
                    // 북마크 색상은 고정
                    HStack {
                        Image(systemName: "bookmark.fill")
                            .foregroundColor(Color.main)
                        
                        Text("1000")
                            .font(.pretendard(weight: .bold, size: 16))
                            .foregroundColor(Color.main)
                    }
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .foregroundColor(Color.gray)
                        
                }
                
                HStack {
                    Text(study.title)
                        .font(.pretendard(weight: .bold, size: 16))
                        .foregroundColor(.black)
                        .lineLimit(1)
                }
            }
            .padding(10)
            .foregroundColor(.clear)
            .background(Color(uiColor: .white))
            .cornerRadius(17)
            .overlay(
                RoundedRectangle(cornerRadius: 17)
                    .inset(by: 0.5)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .shadow(color: Color(red: 0.66, green: 0.69, blue: 0.69).opacity(0.17), radius: 4, x: 0, y: 4)
        }
    }
}

struct ClippyStudyCell_Previews: PreviewProvider {
    static var previews: some View {
        ClippyStudyCell(study: Study.study1)
    }
}
