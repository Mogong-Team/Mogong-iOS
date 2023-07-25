//
//  CreateStudy.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/25.
//

import SwiftUI

struct CreateStudy: View {
    @EnvironmentObject var viewModel: StudyViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var introduction: String = ""
    @State private var memberPreference: String = ""
    @State private var dueDate: Date = Date()
    @State private var selectedStudyType: StudyType?
    @State private var selectedStudyMode: StudyMode?
    @State private var showDatePicker = false
    
    @State private var frequencyOfWeek: Int = 0
    @State private var durationOfMonth: Int = 0
    
    @State private var selectedHostPosition: Field?
    @State private var totalMemberCount: Int = 0
    @State private var backendNeedCount: String = ""
    @State private var frontendNeedCount: String = ""
    @State private var aosNeedCount: String = ""
    @State private var iosNeedCount: String = ""
    @State private var designerNeedCount: String = ""
    @State private var selectProfitGoal: ProfitGoal?
    
    let memberCount = [2, 3, 4, 5, 6, 7, 8, 9, 10]
    let frequency = [1, 2, 3, 4, 5, 6, 7]
    let month = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    
    @State private var showSelectPositionView = false
    @State private var showGeneralStudy = false
    @State private var showProjectStudy = false
    
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
                            Text(dueDate.toYearString())
                        }
                        .foregroundColor(.black)
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
                
                VStack {
                    SelectButton(title: "다음", state: .selected) {
                        if selectedStudyType == .study {
                            showGeneralStudy = true
                        } else {
                            showProjectStudy = true
                        }
                    }
                }
            }
            .padding(.vertical, 10)
        }
        .padding(.horizontal, 20)
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
        .navigationDestination(isPresented: $showGeneralStudy, destination: {
            GeneralStudy()
        })
        .navigationDestination(isPresented: $showProjectStudy, destination: {
            ProjectStudy()
        })
    }
}

struct SelectHostPositionView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedHostPosition: Field?
    
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                ForEach(Field.allCases, id: \.self) { field in
                    Button {
                        selectedHostPosition = field
                    } label: {
                        VStack {
                            Text(field.rawValue)
                                .foregroundColor(.black)
                                .frame(height: 40)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(uiColor: .systemGray6))
                        }
                        .cornerRadius(5)
                        .background(field == selectedHostPosition ? Color(uiColor: .systemGray5) : Color.white)
                    }
                }
            }
            .padding(.horizontal, 20)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}


struct CreateStudy_Previews: PreviewProvider {
    static var previews: some View {
        CreateStudy()
            .environmentObject(StudyViewModel())
            .environmentObject(UserViewModel())
    }
}
