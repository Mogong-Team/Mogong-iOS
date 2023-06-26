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
    @State private var isComplete: Bool = false
    
    @State private var title: String = ""
    @State private var selectedStudyType: StudyType?
    @State private var selectedStudyMode: StudyMode?
    @State private var introduction: String = ""
    @State private var memberPreference: String = ""
    @State private var selectProfitGoal: ProfitGoal?
    @State private var dueDate: Date?
    @State private var languages = [Language]()
    
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
                            
                            SingleLineTextField(text: $title, placeHolder: "")
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("인원")
                                .font(Font.system(size: 16))
                                .frame(height: 25)
                            
                            SingleLineTextField(text: $title, placeHolder: "")
                        }
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("기간")
                                .font(Font.system(size: 16))
                                .frame(height: 25)
                            
                            SingleLineTextField(text: $title, placeHolder: "")
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
                        } label: {
                            Image(systemName: "calendar")
                        }
                    }
                    
                    HStack {
                        Text("사용 언어")
                            .font(Font.system(size: 16))
                            .frame(height: 25)
                        
                        Spacer()
                        
                        Button {
                            // add picker
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
                        isComplete = true
                        // send data
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle("스터디 생성")
    }
}

struct CreateStudy_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateStudy()
        }
    }
}

struct SingleLineTextField: View {
    @Binding var text: String
    var placeHolder: String
    
    var body: some View {
        VStack {
            TextField(placeHolder, text: $text)
                .font(.body)
                .padding(.horizontal, 13)
                .frame(height: 38)
                .overlay {
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(Color.gray, lineWidth: 1)
                }
        }
    }
}

struct MultiLineTextField: View {
    @Binding var text: String
    var placeHolder: String
    
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .font(.body)
                .padding(.horizontal, 13)
                .overlay(
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(Color.gray, lineWidth: 1)
                )
            .onAppear() {
                if text.isEmpty {
                    text = placeHolder
                }
            }
            .foregroundColor(text == placeHolder ? .gray : .primary)
            .onTapGesture {
                if text == placeHolder {
                    text = ""
                }
            }
        }
    }
}

struct SelectButton: View {
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
                    Color.gray
                    
                    Text(title)
                        .font(Font.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                } else {
                    Color.blue
                    
                    Text(title)
                        .font(Font.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                }
            }
            .frame(height: 42)
            .cornerRadius(12)
        }
    }
    
    init(title: String, state: State, action: @escaping () -> Void) {
        self.title = title
        self.state = state
        self.action = action
    }
}
