//
//  SearchStudyView.swift
//  Mogong
//
//  Created by 심현석 on 2023/08/14.
//

import SwiftUI

struct SearchStudyView: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    var body: some View {
        VStack {
            SearchBar(text: $viewModel.searchQuery)
                .padding(.vertical, 10)
            
            if viewModel.filteredWithSearchStudy.isEmpty {
                Text("검색된 내용이 없습니다.")
                    .padding(.top, 250)
            } else {
                ScrollView(showsIndicators: false) {
                    VStack() {
                        ForEach(viewModel.filteredWithSearchStudy) { study in
                            StudyListCell(study: study)
                                .padding(.bottom, 18)
                                .onTapGesture {
                                    viewModel.showStudyDetailOnSearch = true
                                    viewModel.selectedStudy = study
                                }
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .navigationTitle("스터디 검색")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            viewModel.resetSearchView()
        }
        .fullScreenCover(isPresented: $viewModel.showStudyDetailOnSearch) {
            NavigationStack {
                StudyDetailView()
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("원하는 스터디를 검색해주세요.", text: $text)
                    .foregroundColor(.primary)
                
                if !text.isEmpty {
                    Image(systemName: "xmark.circle.fill")
                        .onTapGesture {
                            self.text = ""
                        }
                } else {
                    EmptyView()
                }
            }
            .padding(7)
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
        }
    }
}


struct SearchStudyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchStudyView()
                .environmentObject(StudyViewModel())
        }
    }
}
