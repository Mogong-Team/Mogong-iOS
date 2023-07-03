//
//  BookmarkView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/03.
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray5)
            
            VStack {
                RoundedRectangle(cornerRadius: 43)
                    .foregroundColor(.gray)
                Spacer()
                    .frame(height: UIScreen.main.bounds.height - 200)
            }
            
            VStack {
                Spacer()
                    .frame(height: 80)
                
                HStack {
                    Text("스크랩한 스터디")
                        .font(.pretendard(weight: .bold, size: 32))
                    Spacer()
                }
                
                Spacer()
                    .frame(height: 100)
                
                ScrollView {
                    VStack {
                        ForEach(viewModel.studys, id: \.self) { study in
                            BookmarkCellView(study: study)
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea()
        .navigationTitle("북마크")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
            .environmentObject(StudyViewModel())
    }
}

