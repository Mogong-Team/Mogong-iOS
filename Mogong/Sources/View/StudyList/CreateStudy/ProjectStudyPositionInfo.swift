//
//  ProjectStudyPositionInfo.swift
//  Mogong
//
//  Created by 심현석 on 2023/09/09.
//

import SwiftUI

struct ProjectStudyPositionInfoModal: View {
    @EnvironmentObject var viewModel: StudyViewModel
    @Environment(\.dismiss) var dismiss

    let position: Position
    @State private var requiredCount: Int = 0
    @State private var languages: [Language] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Text("모집인원")
                            .font(.pretendard(weight: .medium, size: 16))
                            .foregroundColor(Color(hexColor: "727272"))
                        
                        HStack {
                            Spacer()
                            ProjectStudyStepper(count: $requiredCount)
                        }
                        .padding(.bottom, 20)
                        
                        Text("학습 언어")
                            .font(.pretendard(weight: .medium, size: 16))
                            .foregroundColor(Color(hexColor: "727272"))
                            .padding(.bottom, 10)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 30) {
                            ForEach(position.language, id: \.self) { language in
                                ProjectStudySelectLanguage(language: language, selectedLanguages: $languages)
                            }
                        }
                    }
                }
                
                ActionButton("적용하기") {
                    dismiss()
                    
                    let positionInfo = PositionInfo(
                        position: position,
                        requiredCount: requiredCount,
                        language: languages
                    )
                    viewModel.setPositionInfo(position: position, positionInfo: positionInfo)
                }
            }
            .padding(.horizontal, 20)
            .navigationTitle(position.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Image(systemName: "xmark")
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
        }
    }
}

struct ProjectStudyStepper: View {
    @Binding var count: Int
    
    var body: some View {
        HStack(spacing:  30) {
            Image(systemName: "minus")
                .font(.pretendard(weight: .bold, size: 15))
                .foregroundColor(Color.main)
                .onTapGesture {
                    if count > 0 {
                        count -= 1
                    }
                }
            Text("\(count)")
                .font(.pretendard(weight: .bold, size: 20))
                .foregroundColor(Color(hexColor: "383838"))
            Image(systemName: "plus")
                .foregroundColor(Color.main)
                .font(.pretendard(weight: .bold, size: 15))
                .onTapGesture {
                    if count < 10 {
                        count += 1
                    }
                }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .frame(width: 190, height: 55)
        .overlay {
            RoundedRectangle(cornerRadius: 44)
                .stroke(Color(hexColor: "DBF6FC"), lineWidth: 2)
        }
    }
}

struct ProjectStudySelectLanguage: View {
    var language: Language
    @Binding var selectedLanguages: [Language] // 변경된 바인딩 이름
    
    var body: some View {
        VStack(spacing: 4) {
            Image(language.imageString)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .background(Color.main)
                .clipShape(Circle())
                .overlay(
                    selectedLanguages.contains(language) // 바인딩된 배열을 확인
                    ? Circle().stroke(Color.red, lineWidth: 3)
                    : nil
                )
                .overlay(
                    selectedLanguages.contains(language) // 바인딩된 배열을 확인
                    ? Image("check")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .offset(x: -20, y: -20)
                    : nil
                )
            
            Text(language.rawValue)
                .font(.pretendard(weight: .bold, size: 16))
                .foregroundColor(Color(hexColor: "5E5A5A"))
        }
        .onTapGesture {
            if selectedLanguages.contains(language) {
                selectedLanguages.removeAll { $0 == language }
            } else if selectedLanguages.count < 3 {
                selectedLanguages.append(language)
            }
        }
    }
}

struct ProjectStudyPositionInfoModal_Previews: PreviewProvider {
    static var previews: some View {
        ProjectStudyPositionInfoModal(position: .backend)
            .environmentObject(StudyViewModel())
    }
}
