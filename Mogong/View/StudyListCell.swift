//
//  StudyListCell.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/21.
//

import SwiftUI

struct StudyListCell: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    @State private var tags = ["모집중", "모집완료", "스터디완주 2회", "#자바스크립트", "#앱개발", "#디자이너"]
    
    @State private var des = ["줌 스터디", "참여인원 10명", "대규모 프로젝트", "화이팅"]
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: .infinity, maximum: .infinity), spacing: nil, alignment: nil)
    ]
    
    var desColumns: [GridItem] = [
        GridItem(.adaptive(minimum: .infinity, maximum: .infinity), spacing: nil, alignment: nil)
    ]
    
    var body: some View {
            HStack {
                VStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
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
                        Text("한달동안 프로젝트 같이해요!")
                            .fontWeight(.bold)
                            .lineLimit(1)
                        .frame(alignment: .leading)

                        Spacer()
                    }
                    
                    LazyVGrid(columns: columns, alignment: .leading, spacing: nil) {
                        ForEach($tags, id: \.self) { tag in
                            tagView(tagType: .label, tag: tag)
                        }
                    }
                    
                    LazyVGrid(columns: desColumns, alignment: .leading) {
                        ForEach($des, id: \.self) { des in
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
        StudyListCell()
    }
}

struct descriptionView: View {
    @Binding var des: String
    
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
    @Binding var tag: String
    
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
