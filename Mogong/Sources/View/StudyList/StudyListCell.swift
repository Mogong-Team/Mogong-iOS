//
//  StudyListCell.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/21.
//

import SwiftUI

struct StudyListCell: View {
    @EnvironmentObject var viewModel: StudyViewModel
    let study: Study
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                HStack(spacing: 5) {
                    RoundRectangleText(text: study.category.rawValue,
                                       background: Color(hexColor: "FF6B00"))
                    RoundRectangleText(text: study.state.rawValue,
                                       background: Color(hexColor: "FFB800"))
                    Text("~ \(study.dueDate.toMonthString())")
                        .font(.pretendard(weight: .semiBold, size: 14))
                        .foregroundColor(Color(hexColor: "7C7979"))
                    Spacer()
                }
                .padding(.top, 16)
                
                Image(systemName: viewModel.checkBookmark(study: study)
                      ? "bookmark.fill"
                      : "bookmark")
                .resizable()
                .frame(width: 18, height: 28)
                .foregroundColor(Color.main)
            }
            
            Text(study.title)
                .foregroundColor(.black)
                .font(.pretendard(weight: .bold, size: 18))
                .multilineTextAlignment(.leading)
            
            RoundRectangleLabel(text: "스터디 비기너",
                                image: Image(systemName: "mic.fill"),
                                background: Color.main)
            
            VStack(alignment: .leading, spacing: 10) {
                CheckLabel(text: study.loaction.rawValue)
                
                if study.category == .generalStudy {
                    CheckLabel(text: "참여 인원 \(study.numberOfRecruits)명 / 주 \(study.frequencyOfWeek)회 진행 (\(study.durationOfMonth)개월)")
                } else if study.category == .projectStudy {
                    CheckLabel(text: "참여 인원 \(viewModel.numberOfRecruits(study: study))명 / 주 \(study.frequencyOfWeek)회 진행 (\(study.durationOfMonth)개월)")
                }
                
                if study.category == .projectStudy {
                    CheckLabel(text: "\(viewModel.positions(study: study)) 모집")
                }
            }
        }
        .padding(.bottom, 20)
        .padding(.horizontal, 22)
        .background(Color.white)
        .cornerRadius(19)
        .shadow(color: Color(white: 0, opacity: 0.1), radius: 5, x: 5, y: 5)
        .overlay {
            RoundedRectangle(cornerRadius: 19)
                .stroke(Color(hexColor: "DBF8FF"), lineWidth: 1)
        }
    }
    
}

struct RoundRectangleText: View {
    var text: String
    var background: Color
    
    var body: some View {
        Text(text)
            .font(.pretendard(weight: .bold, size: 12))
            .foregroundColor(.white)
            .padding(.vertical, 5.5)
            .padding(.horizontal, 8)
            .background(background)
            .cornerRadius(8)
    }
}

struct RoundRectangleLabel: View {
    var text: String
    //var imageString: String
    var image: Image
    var background: Color
    
    var body: some View {
        HStack(spacing: 7) {
            //Image(imageString)
            image
                .resizable()
                .frame(width: 8, height: 11)
            Text(text)
                .font(.pretendard(weight: .bold, size: 12))
        }
        .foregroundColor(.white)
        .padding(.vertical, 5.5)
        .padding(.horizontal, 8)
        .background(background)
        .cornerRadius(8)
    }
}

struct StudyListCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StudyListCell(study: Study.study1)
        }
        .padding(20)
        .environmentObject(StudyViewModel())
    }
}
