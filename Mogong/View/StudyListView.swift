//
//  StudyListView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/21.
//

import SwiftUI

struct StudyListView: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    var items = ["1", "2", "3", "4", "5"]
    
    var body: some View {
            VStack {
                HStack {
                    Button {
                        
                    } label: {
                        Text("인기순")
                            .padding([.leading, .trailing], 10)
                            .padding([.top, .bottom], 5)
                            .background(Color.gray)
                            .foregroundColor(Color.white)
                            .cornerRadius(15)
                    }
                    
                    Button {
                        
                    } label: {
                        Text("최신순")
                            .padding([.leading, .trailing], 10)
                            .padding([.top, .bottom], 5)
                            .background(Color.gray)
                            .foregroundColor(Color.white)
                            .cornerRadius(15)
                    }
                    
                    Button {
                        
                    } label: {
                        Text("포인트순")
                            .padding([.leading, .trailing], 10)
                            .padding([.top, .bottom], 5)
                            .background(Color.gray)
                            .foregroundColor(Color.white)
                            .cornerRadius(15)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 10)
                
                ScrollView {
                    ForEach(items, id:\.self) { item in
                        StudyListCell()
                            .background(Color(uiColor: .systemGray5))
                            .padding(.horizontal, 30)
                            .cornerRadius(30)
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

                    } label: {
                        Image(systemName: "plus")
                            .tint(.black)
                    }
                }
            }
            .searchable(text: $viewModel.searchQuery, prompt: "스터디 검색하기") {
                
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

