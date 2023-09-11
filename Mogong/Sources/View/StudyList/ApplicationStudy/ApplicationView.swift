//
//  ApplicationView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/26.
//

import SwiftUI

struct ApplicationView: View {
    @EnvironmentObject var viewModel: ApplicationViewModel
    @EnvironmentObject var studyViewModel: StudyViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var showSelectPosition: Bool = false
    
    var isComplete: Bool {
        return !viewModel.title.isEmpty &&
        viewModel.position != nil &&
        !viewModel.introduction.isEmpty &&
        !viewModel.experience.isEmpty
    }
   
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("제목")
                    .font(Font.system(size: 16))
                    .frame(height: 25)
                
                SingleLineTextField(
                    text: $viewModel.title,
                    placeHolder: "나를 소개할 제목을 적어주세요!")
            }
            
            HStack {
                Text("지원 포지션")
                    .font(Font.system(size: 16))
                    .frame(height: 25)
                Spacer()
                if viewModel.position == nil {
                    Image("arrow_right")
                } else {
                    Text(viewModel.position?.rawValue ?? "")
                        .font(.pretendard(weight: .bold, size: 16))
                        .foregroundColor(Color.main)
                        .frame(height: 25)
                }
            }
            .onTapGesture {
                showSelectPosition = true
            }
            .padding(.vertical, 10)
            
            VStack(alignment: .leading) {
                Text("간단한 자기소개")
                    .font(Font.system(size: 16))
                    .frame(height: 25)
                
                MultiLineTextField(
                    text: $viewModel.introduction,
                    placeHolder: "")
                    .frame(height: 200)
            }
            
            VStack(alignment: .leading) {
                Text("프로젝트 경험 여부")
                    .font(Font.system(size: 16))
                    .frame(height: 25)
                
                MultiLineTextField(
                    text: $viewModel.experience,
                    placeHolder: "")
                    .frame(height: 200)
            }
            
            Spacer()
            
            ActionButton("지원하기") {
                viewModel.submitApplication(study: studyViewModel.selectedStudy)
                studyViewModel.presentStudyDetail = false
            }
            .disabled(!isComplete)
        }
        .padding(.horizontal, 20)
        .navigationTitle("스터디 지원서")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Image(systemName: "xmark")
                    .onTapGesture {
                        dismiss()
                        viewModel.resetSubmitApplication()
                    }
            }
        }
        .sheet(isPresented: $showSelectPosition) {
            SelectPositionView()
                .presentationDetents([.fraction(0.53)])
        }
        
    }
}

struct ApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ApplicationView()
                .environmentObject(ApplicationViewModel())
        }
    }
}
