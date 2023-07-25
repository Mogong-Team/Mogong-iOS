//
//  BookmarkCellView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/03.
//

import SwiftUI

struct BookmarkCellView: View {
    var study: Study
    
    var body: some View {
        VStack {
            HStack {
                Text(study.state.rawValue)
                    .font(.pretendard(weight: .bold, size: 12))
                    .foregroundColor(.white)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 3)
                    .background(study.state == .completed ? Color.gray : Color.yellow)
                    .cornerRadius(5)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: study.state == .completed
                          ? "bookmark"
                          : "bookmark.fill")
                    .foregroundColor(study.state == .completed
                                     ? Color.black
                                     : Color.yellow)
                }
            }
            
            HStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                    .clipShape(Circle())
                
                VStack {
                    Text(study.title)
                        .font(.pretendard(weight: .bold, size: 13))
                }
                
                Spacer()
            }
            
            HStack {
                VStack {
                    CheckLabel(text: "111")
                    CheckLabel(text: "111")
                }
                Spacer()
            }
        }
    }
}

struct BookmarkCellView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkCellView(study: Study.study1)
    }
}

