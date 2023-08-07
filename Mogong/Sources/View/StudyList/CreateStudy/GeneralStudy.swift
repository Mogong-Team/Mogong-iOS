//
//  GeneralStudy.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/18.
//

import SwiftUI

struct GeneralStudy: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    @State private var frequencyOfWeek: Int = 0
    @State private var durationOfMonth: Int = 0
    
    @State private var selectedField: String?
    let fields = ["프론트엔드", "백엔드", "모바일", "기타"]
    
    @State private var selectedCategory: Bool = true
    
    
    let memberCount = [2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("스터디 생성 : 일반 스터디")
                    .font(.pretendard(weight: .bold, size: 26))
                
                Text("공통 학습 분야 선택")
                    .font(.pretendard(weight: .medium, size: 16))
                
                VStack {
                    HStack(spacing: 0) {
                        GeneralStudySelectCategory(title: "프론트엔드", state: selectedField == "프론트엔드" ? .selected : .unselected) {
                            selectedField = "프론트엔드"
                        }
                        GeneralStudySelectCategory(title: "백엔드", state: selectedField == "백엔드" ? .selected : .unselected) {
                            selectedField = "백엔드"
                        }
                    }
                    HStack(spacing: 0) {
                        GeneralStudySelectCategory(title: "모바일", state: selectedField == "모바일" ? .selected : .unselected) {
                            selectedField = "모바일"
                        }
                        GeneralStudySelectCategory(title: "기타", state: selectedField == "기타" ? .selected : .unselected) {
                            selectedField = "기타"
                        }
                    }
                }
                
                Text("언어는 3개까지 선택이 가능합니다.")
                    .font(.pretendard(weight: .medium, size: 16))
                
                HStack {
                    Spacer()
                    VStack {
                        GeneralStudySelectLanguage(language: "JavaScript")
                        GeneralStudySelectLanguage(language: "Svelte")
                    }
                    Spacer()
                    VStack {
                        GeneralStudySelectLanguage(language: "TypeScript")
                        GeneralStudySelectLanguage(language: "Vue")
                    }
                    Spacer()
                    VStack {
                        GeneralStudySelectLanguage(language: "React")
                        GeneralStudySelectLanguage(language: "Nextjs")
                    }
                    .onTapGesture {
//                        var
//
//                        if GeneralStudySelectLanguage() {
//
//                        }
                    }
                    Spacer()
                }
                
                
    
                GeneralStudySelectFrequencyMenu(frequencyOfWeek: $frequencyOfWeek)
                GeneralStudySelectDurationMenu(durationOfMonth: $durationOfMonth)
//                GeneralStudySelectPersonnelMenu()
    
                Spacer()
                
                SelectButton(title: "생성하기", state: .selected) {
                    // TODO: Post Study
                }
            }
            .navigationTitle("스터디 생성: 일반 스터디")
            .navigationBarTitleDisplayMode(.large)
        .padding(.horizontal, 20)
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
            ZStack {
                if state == .unselected {
                    Color.white
                    
                    Text(title)
                        .font(Font.system(size: 18, weight: .medium))
                        .foregroundColor(.gray)
                } else {
                    Color.blue
                    
                    Text(title)
                        .font(Font.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                }
            }
            .frame(height: 42)
            .cornerRadius(12)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            }
        }
    }
    
    init(title: String, state: State, action: @escaping () -> Void) {
        self.title = title
        self.state = state
        self.action = action
    }
}

    
//    var body: some View {
//        Text(title)
//            .font(.pretendard(weight: .bold, size: 16))
//            .frame(height: 46)
//            .frame(maxWidth: .infinity)
//            .cornerRadius(25)
//            .overlay {
//                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color.blue, lineWidth: 1)
//            }
//    }
//}

struct GeneralStudySelectLanguage: View {
    var language: String = ""
    
    var body: some View {
        VStack {
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)
            
            Text(language)
                .font(.pretendard(weight: .bold, size: 16))
        }
    }
}

struct GeneralStudySelectFrequencyMenu: View {
    @Binding var frequencyOfWeek: Int
    let frequency = [1, 2, 3, 4, 5, 6, 7]
    
    var body: some View {
        HStack {
            Text("횟수")
                .font(.pretendard(weight: .medium, size: 16))
                .frame(height: 25)
            
            Spacer()
            
            Menu {
                ForEach(1...frequency.count, id: \.self) { frequency in
                    Button {
                        frequencyOfWeek = frequency
                    } label: {
                        Text("주 \(String(frequency))일")
                    }
                }
            } label: {
                HStack {
                    if frequencyOfWeek == 0 {
                        Text("일")
                            .foregroundColor(Color(uiColor: .lightGray))
                        
                        Image(systemName: "arrowtriangle.down.fill")
                            .foregroundColor(.gray)
                    } else {
                        Text("주 \(frequencyOfWeek)일")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                }
                .font(.pretendard(weight: .medium, size: 16))
                .padding(.horizontal, 13)
                .frame(width: 110, height: 38)
                .overlay {
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(Color.gray, lineWidth: 1)
                }
            }
        }
    }
}

struct GeneralStudySelectDurationMenu: View {
    @Binding var durationOfMonth: Int
    let month = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    
    var body: some View {
        HStack {
            Text("예상 기간")
                .font(.pretendard(weight: .medium, size: 16))
                .frame(height: 25)
            
            Spacer()
            
            Menu {
                ForEach(1...month.count, id: \.self) { month in
                    Button {
                        durationOfMonth = month
                    } label: {
                        Text("\(String(month))달")
                    }
                }
            } label: {
                HStack {
                    if durationOfMonth == 0 {
                        Text("달")
                            .foregroundColor(Color(uiColor: .lightGray))
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    } else {
                        Text("\(durationOfMonth)달")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                }
                .font(Font.system(size: 16))
                .padding(.horizontal, 13)
                .frame(width: 95, height: 38)
                .overlay {
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(Color.gray, lineWidth: 1)
                }
            }
        }
    }
}

//if durationOfMonth == 0 {
//    Text("달")
//        .foregroundColor(Color(uiColor: .lightGray))
//
//    Image(systemName: "chevron.down")
//        .foregroundColor(.gray)
//} else {
//    Text("\(durationOfMonth)달")
//        .foregroundColor(.black)
//        .fontWeight(.bold)
//}

struct GeneralStudySelectPersonnelMenu: View {
    @Binding var numberOfRecruits: Int
    let personnel = [1, 2, 3, 4, 5, 6, 7]
    
    var body: some View {
        HStack {
            Text("모집 인원")
                .font(.pretendard(weight: .medium, size: 16))
            
            Spacer()
            
            Menu {
                ForEach(1...personnel.count, id: \.self) { person in
                    Button {
                        numberOfRecruits = person
                    } label: {
                        Text("\(String(person))명")
                    }
                }
            } label : {
                HStack {
                    if numberOfRecruits == 0 {
                        Text("명")
                            .foregroundColor(Color(uiColor: .lightGray))
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    } else {
                        Text("\(numberOfRecruits)명")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                }
                .font(Font.system(size: 16))
                .padding(.horizontal, 13)
                .frame(width: 95, height: 38)
                .overlay {
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(Color.gray, lineWidth: 1)
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
}

    //LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 16) {
    //                    ForEach(fields, id: \.self) { field in
    //                        Button(action: {
    //                            selectedField = field
    //                        }) {
    //                            Text(field)
    //                                .frame(maxWidth: .infinity)
    //                                .padding()
    //                                .background(
    //                                    RoundedRectangle(cornerRadius: 8)
    //                                        .fill(selectedField == field ? Color.blue : Color.white)
    //                                        .border(Color.gray, width: 1)
    //                                        .cornerRadius(12)
    //                                )
    //                                .foregroundColor(selectedField == field ? Color.white : Color.gray)
    //                        }
    //                    }
    //                }
    
    
    //                    if durationOfMonth == 0 {
    //                        Text("달")
    //                            .foregroundColor(Color(uiColor: .lightGray))
    //
    //                        Image(systemName: "chevron.down")
    //                            .foregroundColor(.gray)
    //                    } else {
    //                        Text("\(durationOfMonth)달")
    //                            .foregroundColor(.black)
    //                            .fontWeight(.bold)
    //                    }
    //                }
    //                .font(Font.system(size: 16))
    //                .padding(.horizontal, 13)
    //                .frame(width: 95, height: 38)
    //                .overlay {
    //                    RoundedRectangle(cornerRadius: 9)
    //                        .stroke(Color.gray, lineWidth: 1)
