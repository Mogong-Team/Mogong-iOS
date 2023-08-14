//
//  StudyListView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/21.
//

import SwiftUI

struct StudyListView: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                SelectStudyCategory()
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                StudyList()
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Image("nav_mogongLogo")
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink {
                        ChatListView()
                    } label: {
                        Image("message")
                    }
                    
                    NavigationLink {
                        AlarmView()
                    } label: {
                        Image("add")
                    }

                    NavigationLink {
                        AlarmView()
                    } label: {
                        Image("bell_unalarmed")
                        //TODO: 알람왔을 떄 아이콘 변경
                    }
                }
            }
            .navigationDestination(isPresented: $viewModel.presentCreateStudy) {
                CreateStudy()
            }
        }
    }
}

struct SelectStudyCategory: View {
    var body: some View {
        HStack(spacing: 0) {
            SelectStudyCategoryButton(category: .all)
            SelectStudyCategoryButton(category: .generalStudy)
            SelectStudyCategoryButton(category: .projectStudy)
        }
    }
}

struct SelectStudyCategoryButton: View {
    @EnvironmentObject var viewModel: StudyViewModel
    var category: StudyCategory
    
    var body: some View {
        ZStack {
            Text(category.rawValue)
                .font(.pretendard(weight: .bold, size: 14))
                .foregroundColor(viewModel.selectedCategory == category
                                 ? Color.main
                                 : Color(hexColor: "8E8E8E"))
                .onTapGesture {
                    // TODO: GET Stduy
                    viewModel.selectedCategory = category
                }
            
            VStack {
                Spacer()
                Rectangle()
                    .frame(height: viewModel.selectedCategory == category
                           ? 2
                           : 1)
                    .foregroundColor(viewModel.selectedCategory == category
                                     ? Color.main
                                     : Color(hexColor: "CFF6FF"))
            }
        }
        .frame(height: 36)
        .frame(maxWidth: .infinity)
    }
}
    
struct SelectStudyState: View {
    var body: some View {
        HStack {
            SelectStudyStateButton(state: .recruiting)
            SelectStudyStateButton(state: .completed)
            Spacer()
            SelectStudyFilter()
        }
    }
}

struct SelectStudyStateButton: View {
    @EnvironmentObject var viewModel: StudyViewModel
    var state: StudyState
    
    var body: some View {
        Text(state.rawValue)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .font(.pretendard(weight: .bold, size: 14))
            .foregroundColor(viewModel.selectedState == state
                             ? .white
                             : Color.main)
            .background(viewModel.selectedState == state
                        ? Color.main
                        : .white)
            .cornerRadius(9)
            .shadow(color: Color(white: 0, opacity: 0.2), radius: 1, x: 2, y: 2)
            .overlay {
                if viewModel.selectedState != state {
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(Color.main, lineWidth: 1)
                }
            }
            .onTapGesture {
                // TODO: GET Study
                if viewModel.selectedState == state {
                    viewModel.selectedState = nil
                } else {
                    viewModel.selectedState = state
                }
            }
    }
}

struct SelectStudyFilter: View {
    @EnvironmentObject var viewModel: StudyViewModel

    var body: some View {
        HStack {
            Image(systemName: "arrow.up.arrow.down")
                .foregroundColor(Color.main)
            Text(viewModel.isPopularFilter
                 ? "인기순"
                 : "최신순")
                .font(.pretendard(weight: .bold, size: 14))
                .onTapGesture {
                    // TODO: GET Study
                    viewModel.isPopularFilter.toggle()
                }
        }
    }
}

struct StudyList: View {
    @EnvironmentObject var viewModel: StudyViewModel

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    SelectStudyState()
                        .padding(.vertical, 16)
                    
                    ForEach(viewModel.studys) { study in
                        StudyListCell(study: study)
                            .padding(.bottom, 18)
                            .onTapGesture {
                                viewModel.presentStudyDetail = true
                                viewModel.selectedStudy = study
                            }
                            .navigationDestination(isPresented: $viewModel.presentStudyDetail) {
                                StudyDetailView()
                            }
                    }
                }
                .padding(.horizontal, 20)
                .id(1)
            }
            .onChange(of: viewModel.selectedCategory) { _ in
                proxy.scrollTo(1, anchor: .top)
            }
        }
    }
}

struct StudyListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StudyListView()
                .environmentObject(StudyViewModel())
        }
    }
}

