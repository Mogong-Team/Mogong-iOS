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

    @State private var showDatePicker = false
    @State private var showSelectPositionView = false
    @State private var showGeneralStudy = false
    @State private var showProjectStudy = false
    
    var body: some View {
            ScrollView(showsIndicators: false) {
                VStack (spacing: 50) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("모집 형태")
                            .font(.pretendard(weight: .medium, size: 16))
                            .frame(height: 25)
                        
                        HStack {
                            SelectButton(title: "일반 스터디",
                                         state: viewModel.category == .generalStudy
                                         ? .selected
                                         : .unselected) {
                                viewModel.category = .generalStudy
                            }
                            
                            SelectButton(title: "프로젝트 스터디",
                                         state: viewModel.category == .projectStudy
                                         ? .selected
                                         : .unselected) {
                                viewModel.category = .projectStudy
                            }
                        }
                        
                        Text("스터디 방식")
                            .font(.pretendard(weight: .medium, size: 16))
                            .frame(height: 25)
                        
                        HStack {
                            SelectButton(title: "오프라인",
                                         state: viewModel.location == .offline
                                         ? .selected
                                         : .unselected) {
                                viewModel.location = .offline
                            }
                            
                            SelectButton(title: "온라인",
                                         state: viewModel.location == .online
                                         ? .selected
                                         : .unselected) {
                                viewModel.location = .online
                            }
                            
                            SelectButton(title: "온/오프라인",
                                         state: viewModel.location == .both
                                         ? .selected
                                         : .unselected) {
                                viewModel.location = .both
                            }
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("제목")
                            .font(.pretendard(weight: .medium, size: 16))
                            .frame(height: 25)
                        
                        SingleLineTextField(text: $viewModel.title, placeHolder: "스터디를 소개할 제목을 적어주세요!")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("스터디 소개글")
                            .font(.pretendard(weight: .medium, size: 16))
                            .frame(height: 25)
                        
                        MultiLineTextField(text: $viewModel.introduction, placeHolder: "나의 스터디를 소개할 글을 입력해주세요.")
                            .frame(height: 180)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("이런 팀원을 뽑아요!")
                            .font(.pretendard(weight: .medium, size: 16))
                            .frame(height: 25)
                        
                        MultiLineTextField(text: $viewModel.memberPreference, placeHolder: "팀원의 자격요건을 적어주세요!")
                            .frame(height: 180)
                    }
                    
                    VStack {
                        HStack {
                            Text("마감 일자")
                                .font(.pretendard(weight: .medium, size: 16))
                                .frame(height: 25)
                            
                            Spacer()
                            
                            Button {
                                // add calendar
                                showDatePicker = true
                            } label: {
                                Image(systemName: "calendar")
                                Text(viewModel.dueDate.toYearString())
                            }
                            .foregroundColor(.black)
                        }
                    }
                    
                    
                    
                    VStack {
                        SelectButton(title: "다음", state: .selected) {
                            if viewModel.category == .generalStudy {
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
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .onTapGesture {
                            viewModel.presentStudyDetail = false
                        }
                }
            }
            .sheet(isPresented: $showDatePicker) {
                DatePicker("", selection: $viewModel.dueDate, displayedComponents: .date)
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
    @Binding var selectedHostPosition: Position?
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                ForEach(Position.allCases, id: \.self) { position in
                    Button {
                        selectedHostPosition = position
                    } label: {
                        VStack {
                            Text(position.rawValue)
                                .foregroundColor(.black)
                                .frame(height: 40)
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(uiColor: .systemGray6))
                        }
                        .cornerRadius(5)
                        .background(position == selectedHostPosition
                                    ? Color(uiColor: .systemGray5)
                                    : Color.white)
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
