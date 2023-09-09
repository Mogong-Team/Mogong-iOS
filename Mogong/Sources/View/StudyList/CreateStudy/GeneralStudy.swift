//
//  GeneralStudy.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/18.
//

import SwiftUI

struct GeneralStudy: View {
    @EnvironmentObject var viewModel: StudyViewModel
    @State private var selectedCategory: GeneralStudyCategory = .backend
    
    var isCompleted: Bool {
        return viewModel.frequencyOfWeek != 0
        && viewModel.durationOfMonth != 0
        && viewModel.numberOfRecruits != 0
        && viewModel.language != []
    }
        
    var body: some View {
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Text("공통 학습 분야 선택")
                            .font(.pretendard(weight: .medium, size: 16))
                            .foregroundColor(Color(hexColor: "727272"))
                            .padding(.bottom, 10)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(spacing: 5), count: 2), spacing: 5) {
                            ForEach(GeneralStudyCategory.allCases, id: \.self) { category in
                                GeneralStudySelectCategory(title: category.rawValue, state: selectedCategory == category ? .selected : .unselected) {
                                    self.selectedCategory = category
                                }
                            }
                        }
                        .padding(5)
                        .frame(height: 102)
                        .background(Color(hexColor: "DAF8FF"))
                        .cornerRadius(9)
                        .padding(.bottom, 30)
                        
                        Text("언어는 3개까지 선택이 가능합니다.")
                            .font(.pretendard(weight: .regular, size: 13))
                            .foregroundColor(Color(hexColor: "5E5A5A"))
                            .padding(.bottom, 10)

                        LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 30) {
                            ForEach(selectedCategory.language, id: \.self) { language in
                                GeneralStudySelectLanguage(language: language)
                            }
                        }
                        .padding(.bottom, 20)
                        
                        VStack(spacing: 20) {
                            GeneralStudySelectFrequencyMenu()
                            GeneralStudySelectDurationMenu()
                            GeneralStudySelectPersonnelMenu()
                        }
                        .padding(.bottom, 20)
                        
                        ActionButton("생성하기") {
                            viewModel.presentCreateStudy = false
                            viewModel.createStudy()
                            viewModel.resetCreateStudy()
                        }
                        .disabled(!isCompleted)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    .padding(.horizontal, 20)
                }
            }
            .navigationTitle("스터디 생성 : 일반 스터디")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Image(systemName: "xmark")
                        .fontWeight(.bold)
                        .onTapGesture {
                            viewModel.presentCreateStudy = false
                        }
                }
            }
    }
}

struct GeneralStudySelectCategory: View {
    enum State {
        case selected
        case unselected
    }
    
    private let title: String
    private let state: State
    private let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.pretendard(weight: .bold, size: 16))
                .foregroundColor(Color(hexColor: "5E5A5A"))
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(.white)
                .cornerRadius(4)
                .overlay {
                    if state == .selected {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.main, lineWidth: 3)
                    }
                }
        }
    }
    
    init(title: String, state: State, action: @escaping () -> Void) {
        self.title = title
        self.state = state
        self.action = action
    }
}

struct GeneralStudySelectLanguage: View {
    @EnvironmentObject var viewModel: StudyViewModel
    var language: Language
    
    var body: some View {
        VStack(spacing: 4) {
            Image(language.imageString)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay(
                    viewModel.language.contains(where: { $0 == language })
                    ? Circle().stroke(Color.red, lineWidth: 3)
                    : nil
                )
                .overlay(
                    viewModel.language.contains(where: { $0 == language })
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
            if viewModel.language.contains(where: { $0 == language }) {
                viewModel.language.removeAll(where: { $0 == language})
            } else if viewModel.language.count < 3 {
                viewModel.language.append(language)
            }
        }
    }
}

struct GeneralStudySelectFrequencyMenu: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    var body: some View {
        HStack {
            Text("횟수")
                .font(.pretendard(weight: .medium, size: 16))
                .foregroundColor(Color(hexColor: "727272"))
            
            Spacer()
            
            Menu {
                ForEach(1...7, id: \.self) { frequency in
                    Button {
                        viewModel.frequencyOfWeek = frequency
                    } label: {
                        Text("주 \(String(frequency))회")
                    }
                }
            } label: {
                HStack {
                    if viewModel.frequencyOfWeek == 0 {
                        Text("회")
                            .foregroundColor(Color(hexColor: "D9D9D9"))
                        Image("Polygon2")
                    } else {
                        Text("주 \(viewModel.frequencyOfWeek)회")
                            .foregroundColor(Color(hexColor: "727272"))
                            .fontWeight(.medium)
                    }
                }
                .font(.pretendard(weight: .medium, size: 16))
                .padding(.horizontal, 13)
                .frame(width: 95, height: 40)
                .overlay {
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(Color(hexColor: "DBF6FC"), lineWidth: 2)
                }
            }
        }
    }
}

struct GeneralStudySelectDurationMenu: View {
    @EnvironmentObject var viewModel: StudyViewModel
        
    var body: some View {
        HStack {
            Text("예상 기간")
                .font(.pretendard(weight: .medium, size: 16))
                .foregroundColor(Color(hexColor: "727272"))

            Spacer()
            
            Menu {
                ForEach(1...6, id: \.self) { month in
                    Button {
                        viewModel.durationOfMonth = month
                    } label: {
                        Text("\(String(month))개월")
                    }
                }
            } label: {
                HStack {
                    if viewModel.durationOfMonth == 0 {
                        Text("달")
                            .foregroundColor(Color(hexColor: "D9D9D9"))
                        Image("Polygon2")
                    } else {
                        Text("\(viewModel.durationOfMonth)개월")
                            .foregroundColor(Color(hexColor: "727272"))
                            .fontWeight(.medium)
                    }
                }
                .font(Font.system(size: 16))
                .padding(.horizontal, 13)
                .frame(width: 95, height: 40)
                .overlay {
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(Color(hexColor: "DBF6FC"), lineWidth: 2)
                }
            }
        }
    }
}

struct GeneralStudySelectPersonnelMenu: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    var body: some View {
        HStack {
            Text("모집 인원")
                .font(.pretendard(weight: .medium, size: 16))
                .foregroundColor(Color(hexColor: "727272"))

            Spacer()
            
            Menu {
                ForEach(1...10, id: \.self) { person in
                    Button {
                        viewModel.numberOfRecruits = person
                    } label: {
                        Text("\(String(person))명")
                    }
                }
            } label : {
                HStack {
                    if viewModel.numberOfRecruits == 0 {
                        Text("명")
                            .foregroundColor(Color(hexColor: "D9D9D9"))
                        Image("Polygon2")
                    } else {
                        Text("\(viewModel.numberOfRecruits)명")
                            .foregroundColor(Color(hexColor: "727272"))
                            .fontWeight(.medium)
                    }
                }
                .font(Font.system(size: 16))
                .padding(.horizontal, 13)
                .frame(width: 95, height: 38)
                .overlay {
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(Color(hexColor: "DBF6FC"), lineWidth: 2)
                }
            }
        }
    }
}

struct GeneralStudy_Previews: PreviewProvider {
    static var previews: some View {
        GeneralStudy()
            .environmentObject(StudyViewModel())
    }
}
