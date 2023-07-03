//
//  CreateStudy.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/25.
//

import SwiftUI

struct CreateStudy: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var frequencyOfWeek: Int?
    @State private var totalMemberCount: Int?
    @State private var durationOfMonth: Int?
    @State private var selectedStudyType: StudyType?
    @State private var selectedStudyMode: StudyMode?
    @State private var introduction: String = ""
    @State private var memberPreference: String = ""
    @State private var selectProfitGoal: ProfitGoal?
    @State private var dueDate: Date = Date()
    @State private var selectedlanguages = Set<Language>()
    
    @State private var showDatePicker = false
    @State private var showSelectLanguagesView = false
    
    let frequency = [1, 2, 3, 4, 5, 6, 7]
    let memberCount = [2, 3, 4, 5, 6, 7, 8, 9, 10]
    let month = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                VStack(alignment: .leading) {
                    Text("제목")
                        .font(Font.system(size: 16))
                        .frame(height: 25)
                    
                    SingleLineTextField(text: $title, placeHolder: "스터디를 소개할 제목을 적어주세요!")
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        VStack(alignment: .leading, spacing: 0) {
                            Text("횟수")
                                .font(Font.system(size: 16))
                                .frame(height: 25)
                            
                            Menu {
                                ForEach(0..<frequency.count, id: \.self) { frequency in
                                    Button {
                                        frequencyOfWeek = frequency
                                    } label: {
                                        Text("주 \(String(frequency))일")
                                    }
                                }
                            } label: {
                                HStack {
                                    if let frequency = frequencyOfWeek {
                                        Text("주 \(frequency)일")
                                            .foregroundColor(.black)
                                            .fontWeight(.bold)
                                    } else {
                                        Text("일")
                                            .foregroundColor(Color(uiColor: .lightGray))
                                        
                                        Image(systemName: "arrowtriangle.down.fill")
                                            .foregroundColor(.gray)
                                    }
                                }
                                .font(Font.system(size: 16))
                                .padding(.horizontal, 13)
                                .frame(height: 38)
                                .frame(maxWidth: .infinity)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 9)
                                        .stroke(Color.gray, lineWidth: 1)
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("인원")
                                .font(Font.system(size: 16))
                                .frame(height: 25)
                            
                            Menu {
                                ForEach(0..<memberCount.count, id: \.self) { count in
                                    Button {
                                        totalMemberCount = count
                                    } label: {
                                        Text("\(String(count))명")
                                    }
                                }
                            } label: {
                                HStack {
                                    if let member = totalMemberCount {
                                        Text("\(member)명")
                                            .foregroundColor(.black)
                                            .fontWeight(.bold)
                                    } else {
                                        Text("명")
                                            .foregroundColor(Color(uiColor: .lightGray))
                                        
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(.gray)
                                    }
                                }
                                .font(Font.system(size: 16))
                                .padding(.horizontal, 13)
                                .frame(height: 38)
                                .frame(maxWidth: .infinity)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 9)
                                        .stroke(Color.gray, lineWidth: 1)
                                }                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("기간")
                                .font(Font.system(size: 16))
                                .frame(height: 25)
                            
                            Menu {
                                ForEach(0..<month.count, id: \.self) { month in
                                    Button {
                                        durationOfMonth = month
                                    } label: {
                                        Text("\(String(month))달")
                                    }
                                }
                            } label: {
                                HStack {
                                    if let month = durationOfMonth {
                                        Text("\(month)달")
                                            .foregroundColor(.black)
                                            .fontWeight(.bold)
                                    } else {
                                        Text("달")
                                            .foregroundColor(Color(uiColor: .lightGray))
                                        
                                        Image(systemName: "chevron.down")
                                            .foregroundColor(.gray)
                                    }
                                }
                                .font(Font.system(size: 16))
                                .padding(.horizontal, 13)
                                .frame(height: 38)
                                .frame(maxWidth: .infinity)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 9)
                                        .stroke(Color.gray, lineWidth: 1)
                                }
                            }
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("모집 형태")
                        .font(Font.system(size: 16))
                        .frame(height: 25)
                    
                    HStack {
                        SelectButton(title: "스터디", state: selectedStudyType == .study ? .selected : .unselected) {
                            selectedStudyType = .study
                        }
                        
                        SelectButton(title: "팀 프로젝트", state: selectedStudyType == .teamProject ? .selected : .unselected) {
                            selectedStudyType = .teamProject
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("스터디 방식")
                        .font(Font.system(size: 16))
                        .frame(height: 25)
                    
                    HStack {
                        SelectButton(title: "오프라인", state: selectedStudyMode == .offline ? .selected : .unselected) {
                            selectedStudyMode = .offline
                        }
                        
                        SelectButton(title: "온라인", state: selectedStudyMode == .online ? .selected : .unselected) {
                            selectedStudyMode = .online
                        }
                        
                        SelectButton(title: "온/오프라인", state: selectedStudyMode == .both ? .selected : .unselected) {
                            selectedStudyMode = .both
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("스터디 소개글")
                        .font(Font.system(size: 16))
                        .frame(height: 25)
                    
                    MultiLineTextField(text: $introduction, placeHolder: "나의 스터디를 소개할 글을 입력해주세요")
                        .frame(height: 180)
                }
                
                VStack(alignment: .leading) {
                    Text("이런 팀원을 뽑아요!")
                        .font(Font.system(size: 16))
                        .frame(height: 25)
                    
                    MultiLineTextField(text: $memberPreference, placeHolder: "팀원의 자격요건을 적어주세요!")
                        .frame(height: 180)
                }
                
                VStack {
                    HStack {
                        Text("마감 일자")
                            .font(Font.system(size: 16))
                            .frame(height: 25)
                        
                        Spacer()
                        
                        Button {
                            // add calendar
                            showDatePicker = true
                        } label: {
                            Image(systemName: "calendar")
                            Text(dueDate.toString())
                        }
                        .foregroundColor(.black)
                    }
                    
                    HStack {
                        Text("사용 언어")
                            .font(Font.system(size: 16))
                            .frame(height: 25)
                        
                        Spacer()
                        
                        Button {
                            // add picker
                            showSelectLanguagesView =  true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("수익화 목적")
                        .font(Font.system(size: 16))
                        .frame(height: 25)
                    
                    HStack {
                        SelectButton(title: "있음", state: selectProfitGoal == .yes ? .selected : .unselected) {
                            selectProfitGoal = .yes
                        }
                        
                        SelectButton(title: "없음", state: selectProfitGoal == .no ? .selected : .unselected) {
                            selectProfitGoal = .no
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("해시태그")
                        .font(Font.system(size: 16))
                        .frame(height: 25)
                    
                    SingleLineTextField(text: $title, placeHolder: "나의 스터디를 소개할 해시태그를 입력해주세요")
                }
                
                VStack {
                    SelectButton(title: "스터디 생성", state: .selected) {
                        dismiss()
                        // send data
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle("스터디 생성")
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
        .sheet(isPresented: $showDatePicker) {
            DatePicker("", selection: $dueDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .environment(\.locale, Locale.init(identifier: "ko_KR"))
                .presentationDetents([.fraction(0.5)])
        }
        .sheet(isPresented: $showSelectLanguagesView) {
            NavigationStack {
                SelectLanguageView(selectedLanguage: $selectedlanguages)
            }
        }
    }
}

struct CreateStudy_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateStudy()
        }
    }
}
