//
//  StudyListCell.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/21.
//

import SwiftUI

struct StudyListCell: View {
    let study: Study
    
    var des = ["줌 스터디", "참여인원 10명", "대규모 프로젝트", "화이팅"]
    
    var body: some View {
        HStack {
            VStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                    .clipShape(Circle())
                
                Spacer()
            }
            
            VStack {
                HStack {
                    Text("~2023.06.28")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "heart")
                            .tint(.red)
                    }
                }
                
                HStack {
                    Text(study.title)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .frame(alignment: .leading)
                    
                    Spacer()
                }
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], alignment: .leading, spacing: nil) {
                    ForEach(study.hashtags, id: \.self) { tag in
                        tagView(tagType: .label, tag: tag)
                    }
                }
                
                LazyVGrid(columns: [GridItem(.flexible())], alignment: .leading, spacing: nil) {
                    ForEach(des, id: \.self) { des in
                        descriptionView(des: des)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

struct StudyListCell_Previews: PreviewProvider {
    static var previews: some View {
        StudyListCell(study: Study(title: "한달동안 프로젝트 같이해요!", frequencyOfWeek: 2, durationOfMonth: 2, studyType: .teamProject,studyMode: .online, totalMemberCount: 5, host: User(id: "1", name: "김방장", email: "a@gmail.com", username: "나방장"), introduction: "안녕하세요", memberPreference: "누구든 상관없어요", hashtags: ["#자바스크립트", "#앱개발", "#디자이너"], dueDate: Date(timeIntervalSinceNow: 24*3600*7), languages: [.javaScript, .figma, .swift], fields: [.backend, .designer], profitGoal: .no, isBookMarked: true, isRecruitmentCompleted: false))
    }
}

struct descriptionView: View {
    var des: String
    
    var body: some View {
        Label {
            Text(des)
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.gray)
        } icon: {
            Image(systemName: "checkmark")
                .foregroundColor(.blue)
        }
    }
}

enum TagType {
    case text
    case label
}

struct tagView: View {
    var tagType: TagType
    var tag: String
    
    var body: some View {
        switch tagType {
        case .text:
            Text(tag)
                .font(.subheadline)
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .background(.yellow)
                .foregroundColor(.white)
                .cornerRadius(10)
                .lineLimit(1)
            
        case .label:
            HStack {
                Image(systemName: "heart.fill")
                Text(tag)
            }
            .font(.subheadline)
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(.purple)
            .cornerRadius(10)
            .lineLimit(1)
        }
    }
}
