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
    @State private var frequencyOfWeek: Int = 0
    @State private var totalMemberCount: Int = 0
    @State private var durationOfMonth: Int = 0
    @State private var selectedStudyType: StudyType?
    @State private var selectedStudyMode: StudyMode?
    @State private var introduction: String = ""
    @State private var memberPreference: String = ""
    @State private var selectProfitGoal: ProfitGoal?
    @State private var dueDate: Date = Date()
    @State private var selectedHostPosition: Field?
    
    @State private var showDatePicker = false
    @State private var showSelectPositionView = false
    
    let memberCount = [2, 3, 4, 5, 6, 7, 8, 9, 10]
    let frequency = [1, 2, 3, 4, 5, 6, 7]
    let month = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    
    @State private var backendNeedCount: String = ""
    @State private var frontendNeedCount: String = ""
    @State private var aosNeedCount: String = ""
    @State private var iosNeedCount: String = ""
    @State private var designerNeedCount: String = ""
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                VStack(alignment: .leading) {
                    Text("제목")
                        .font(Font.system(size: 16))
                        .frame(height: 25)
                    
                    SingleLineTextField(text: $title, placeHolder: "스터디를 소개할 제목을 적어주세요!")
                }
                
                VStack {
                    VStack(alignment: .leading) {
                        Text("모집인원")
                            .font(Font.system(size: 16))
                            .frame(height: 25)
                        
                        VStack(spacing: 5) {
                            HStack {
                                Text("나의 포지션")
                                    .foregroundColor(.gray)
                                Spacer()
                                Button {
                                    // add picker
                                    showSelectPositionView =  true
                                } label: {
                                    if selectedHostPosition == nil {
                                        Text("선택")
                                            .foregroundColor(.black)
                                            .fontWeight(.bold)
                                    } else {
                                        Text(selectedHostPosition?.rawValue ?? "")
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            
                            HStack {
                                Text("프론트엔드")
                                    .foregroundColor(.gray)
                                Spacer()
                                TextField("인원", text: $frontendNeedCount)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 50, height: 38)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.gray, lineWidth: 1)
                                    }
                            }
                            
                            HStack {
                                Text("백엔드")
                                    .foregroundColor(.gray)
                                Spacer()
                                TextField("인원", text: $backendNeedCount)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 50, height: 38)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.gray, lineWidth: 1)
                                    }
                            }
                            
                            HStack {
                                Text("디자이너")
                                    .foregroundColor(.gray)
                                Spacer()
                                TextField("인원", text: $designerNeedCount)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 50, height: 38)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.gray, lineWidth: 1)
                                    }
                            }
                            
                            HStack {
                                Text("안드로이드")
                                    .foregroundColor(.gray)
                                Spacer()
                                TextField("인원", text: $aosNeedCount)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 50, height: 38)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.gray, lineWidth: 1)
                                    }
                            }
                            
                            HStack {
                                Text("iOS")
                                    .foregroundColor(.gray)
                                Spacer()
                                TextField("인원", text: $iosNeedCount)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 50, height: 38)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.gray, lineWidth: 1)
                                    }
                            }
                        }
                    }
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
                        
                        let study = Study(id: "11", title: title, frequencyOfWeek: frequencyOfWeek, durationOfMonth: durationOfMonth, studyType: selectedStudyType ?? .study, studyMode: selectedStudyMode ?? .both, totalMemberCount: totalMemberCount,
                                          requiredPositions: [
                            Position(field: .backend, requiredFieldCount: Int(backendNeedCount) ?? 0),
                            Position(field: .frontend, requiredFieldCount: Int(frontendNeedCount) ?? 0),
                            Position(field: .designer, requiredFieldCount: Int(designerNeedCount) ?? 0),
                            Position(field: .aos, requiredFieldCount: Int(aosNeedCount) ?? 0),
                            Position(field: .ios, requiredFieldCount: Int(iosNeedCount) ?? 0)
                        ], host: Member(user: userViewModel.currentUser, field: selectedHostPosition ?? .backend), currentMember: [
                            Member(user: userViewModel.currentUser, field: selectedHostPosition ?? .backend)
                        ], introduction: introduction, memberPreference: memberPreference, hashtags: [], createDate: Date(), dueDate: dueDate, languages: [], fields: [], profitGoal: selectProfitGoal ?? .no, isBookMarked: false, bookMarkCount: 0, isRecruitmentCompleted: false, isStudyCompleted: false)
    
                        viewModel.studys.append(study)
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
        .sheet(isPresented: $showSelectPositionView) {
            //NavigationStack {
                SelectHostPositionView(selectedHostPosition: $selectedHostPosition)
                    .presentationDetents([.fraction(0.4)])
            //}
        }
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
