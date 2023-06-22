//
//  StudyListView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/21.
//

import SwiftUI

struct StudyListView: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    @State private var selectedFilter: Int = 0
    
    var items = ["1", "2", "3", "4", "5"]
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    selectedFilter = 0
                } label: {
                    Text("인기순")
                        .padding([.leading, .trailing], 10)
                        .padding([.top, .bottom], 5)
                        .background(selectedFilter == 0 ? Color.gray : Color(uiColor: .systemGray6))
                        .foregroundColor(selectedFilter == 0 ? .white : .black)
                        .font(.system(size: 17, weight: .bold))
                        .cornerRadius(15)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                }
                
                Button {
                    selectedFilter = 1
                } label: {
                    Text("최신순")
                        .padding([.leading, .trailing], 10)
                        .padding([.top, .bottom], 5)
                        .background(selectedFilter == 1 ? Color.gray : Color(uiColor: .systemGray6))
                        .foregroundColor(selectedFilter == 1 ? .white : .black)
                        .font(.system(size: 17, weight: .bold))
                        .cornerRadius(15)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            ScrollView {
                ForEach(items, id:\.self) { item in
                    NavigationLink {
                        // 스터디 상세 보기
                    } label: {
                        StudyListCell()
                            .background(Color(uiColor: .systemGray5))
                            .cornerRadius(20)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Text("Mogong")
                    .font(.title2)
                    .fontWeight(.heavy)
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                NavigationLink {
                    // add study
                } label: {
                    Image(systemName: "plus.circle")
                        .tint(.black)
                }
            }
        }
        .searchable(text: $viewModel.searchQuery, prompt: "스터디 검색하기") {
            // search action
        }
    }
}

struct StudyListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StudyListView()
                .environmentObject(StudyViewModel())
        }
    }
}

