//
//  StudyDetailView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/28.
//

import SwiftUI

enum ViewType: Int {
    case introduction = 0
    case member = 1
    case output = 2
    
    var title: String {
        switch self {
        case .introduction:
            return "프로젝트 소개"
        case .member:
            return "스터디원"
        case .output:
            return "아웃풋"
        }
    }
}

struct StudyIntroduceView: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    @State private var viewType: ViewType = .introduction
        
    var body: some View {
        ZStack {
            Color(uiColor: .systemMint)
            
            VStack {
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("아메리카노")
                            .font(Font.system(size: 15, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text(viewModel.study.title)
                            .font(Font.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                
                Spacer()
                    .frame(height: 10)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundColor(.white)
                        
                    VStack {
                        HStack {
                            Button {
                                if let newViewType = ViewType(rawValue: viewType.rawValue - 1) {
                                    viewType = newViewType
                                }
                            } label: {
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                            }
                            
                            Spacer()
                                
                            Text(viewType.title)
                                .font(Font.system(size: 24, weight: .bold))
                            
                            Spacer()
                            
                            Button {
                                if let newViewType = ViewType(rawValue: viewType.rawValue + 1) {
                                    viewType = newViewType
                                }
                            } label: {
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                            }
                        }
                        
                        Spacer()
                            .frame(height: 10)
                        
                        detailView(study: viewModel.study, viewType: $viewType)
                        
                        Spacer()
                    }
                    .padding(.vertical, 30)
                    .padding(.horizontal, 20)
                }
                .frame(height: UIScreen.main.bounds.height - 290)
            }
        }
        .ignoresSafeArea()
    }
}

struct StudyIntroduceView_Previews: PreviewProvider {
    static var previews: some View {
        StudyIntroduceView()
            .environmentObject(StudyViewModel())
    }
}

struct detailView: View {
    var study: Study
    @Binding var viewType: ViewType
    
    var body: some View {
        VStack {
            if viewType == .introduction {
                HStack {
                    Text(study.introduction)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
            } else if viewType == .member {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(study.currentMembers, id: \.self) { member in
                        HStakTeamMemberView(member: member, isSelected: false)
                    }
                }
            }
        }
    }
}
