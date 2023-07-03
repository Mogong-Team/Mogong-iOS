//
//  ApplicationView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/26.
//

import SwiftUI

struct ApplicationView: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    @Environment(\.dismiss) var dismiss
    @State private var isComplete: Bool = false
    @State private var showChat: Bool = false
    
    @State private var title: String = ""
    @State private var field: String = ""
    @State private var introduction: String = ""
    @State private var experience: String = ""
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("제목")
                    .font(Font.system(size: 16))
                    .frame(height: 25)
                
                SingleLineTextField(text: $title, placeHolder: "나를 소개할 제목을 적어주세요!")
            }
            
            VStack(alignment: .leading) {
                Text("지원 분야")
                    .font(Font.system(size: 16))
                    .frame(height: 25)
                
                SingleLineTextField(text: $field, placeHolder: "지원 분야를 입력해 주세요!")
            }
            
            VStack(alignment: .leading) {
                Text("간단한 자기소개")
                    .font(Font.system(size: 16))
                    .frame(height: 25)
                
                MultiLineTextField(text: $introduction, placeHolder: "나의 나타낼 간단한 소개할 글을 작성해주세요!")
                    .frame(height: 180)
            }
            
            VStack(alignment: .leading) {
                Text("프로젝트 경험 여부")
                    .font(Font.system(size: 16))
                    .frame(height: 25)
                
                MultiLineTextField(text: $experience, placeHolder: "프로젝트 경험 여부를 적어주세요!")
                    .frame(height: 180)
            }
            
            HStack {
                SelectButton(title: "문의하기", state: .unselected) {
                    showChat = true
                }
                
                SelectButton(title: "지원하기", state: .selected) {
                    isComplete = true
                }
            }
        }
        .padding(.horizontal, 20)
        .navigationTitle("스터디 지원서")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .tint(.black)
                }
            }
        }
        .navigationDestination(isPresented: $isComplete) {
            // next page
        }
        .navigationDestination(isPresented: $showChat) {
            ChatListView()
        }
    }
}

struct ApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ApplicationView()
        }
    }
}
