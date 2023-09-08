//
//  BookmarkView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/03.
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var viewModel: StudyViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                NaviBackButton()
                
                HStack(spacing: 12) {
                    Image(systemName: "bookmark.fill")
                        .resizable()
                        .frame(width: 15, height: 21)
                        .foregroundColor(Color.main)
                    Text("스크랩한 스터디")
                        .font(.pretendard(weight: .bold, size: 24))
                        .foregroundColor(Color(hexColor: "4E4E4E"))
                    Spacer()
                }
            }
            .ignoresSafeArea()
            .padding(20)
            .background(Color(hexColor: "E8F5FF"))
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(viewModel.allStudys) { study in
                        StudyListCell(study: study)
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
            .environmentObject(StudyViewModel())
    }
}

