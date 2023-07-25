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
                    RoundRectangleText(text: "프로젝트형",
                                       background: Color(hexColor: "FF6B00"))
                    RoundRectangleText(text: "모집중",
                                       background: Color(hexColor: "FFB800"))
                    Text("~ 6월 28일")
                        .font(.pretendard(weight: .semiBold, size: 14))
                        .foregroundColor(Color(hexColor: "7C7979"))
                    Spacer()
                }
                .padding(.top, 16)
                
                Image(systemName: viewModel.isBookmarked
                      ? "bookmark.fill"
                      : "bookmark")
                .resizable()
                .frame(width: 18, height: 28)
                .foregroundColor(Color(hexColor: "00C7F4"))
                .onTapGesture {
                    viewModel.isBookmarked.toggle()
                    // TODO: 북마크
                }
            }
            
            Text(study.title)
                .foregroundColor(.black)
                .font(.pretendard(weight: .bold, size: 18))
                .multilineTextAlignment(.leading)
            
            RoundRectangleLabel(text: "스터디 비기너",
                                image: Image(systemName: "mic.fill"),
                                background: Color(hexColor: "00C7F4"))
            
            VStack(alignment: .leading, spacing: 10) {
                CheckLabel(text: study.studyMode.rawValue, isHighlighted: false)
                CheckLabel(text: "참여 인원 10명 / 주 3회 진행 (2개월)", isHighlighted: false)
                CheckLabel(text: "프론트엔드 / 하이브리드 모집", isHighlighted: false)
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
            StudyListCell(study:
                            Study(id: "1", title: "한달동안 프로젝트 같이해요!ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ", frequencyOfWeek: 2, durationOfMonth: 2,
                                  studyType: .teamProject, studyMode: .online, totalMemberCount: 5,
                                  requiredPositions: [
                                    Position(field: .backend, requiredFieldCount: 2),
                                    Position(field: .frontend, requiredFieldCount: 1),
                                    Position(field: .designer, requiredFieldCount: 1),
                                    Position(field: .ios, requiredFieldCount: 1)
                                  ],
                                  host: Member(user: User(id: "1", name: "김방장", email: "a@gmail.com", username: "나방장"), field: .backend),
                                  currentMember: [
                                    Member(user: User(id: "1", name: "김방장", email: "a@gmail.com", username: "나방장"), field: .backend),
                                    Member(user: User(id: "2", name: "박민수", email: "a@gmail.com", username: "박민수"), field: .frontend),
                                    Member(user: User(id: "3", name: "최민수", email: "a@gmail.com", username: "최민수"),  field: .ios)
                                  ],
                                  introduction: "안녕하세요", memberPreference: "누구든 상관없어요", hashtags: ["#자바스크립트", "#앱개발", "#디자이너"],
                                  createDate: Date(), dueDate: Date(timeIntervalSinceNow: 24*3600*7), languages: [.javaScript, .figma, .swift],
                                  fields: [.backend, .designer], profitGoal: .no,
                                  isBookMarked: true, bookMarkCount: 5, isRecruitmentCompleted: false, isStudyCompleted: false)
            )
        }
        .padding(20)
        .environmentObject(StudyViewModel())
    }
}
