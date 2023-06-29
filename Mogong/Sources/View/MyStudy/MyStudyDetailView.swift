//
//  MyStudyDetailView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/29.
//

import SwiftUI

struct MyStudyDetailView: View {
    enum ViewType {
        case host
        case member
    }
    
    @EnvironmentObject var viewModel: StudyViewModel
    
    @State private var viewType: ViewType = .host
        
    var body: some View {
        ZStack {
            Color(uiColor: .lightGray)
            
            VStack {
                Spacer()
                
                Text("나의 스터디")
                    .font(.pretendard(weight: .bold, size: 28))
                    .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 85)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundColor(.white)
                       
                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("스터디 소개글")
                                .font(.pretendard(weight: .bold, size: 20))
                            
                            Spacer()
                                .frame(height: 15)
                            
                            Text(viewModel.study.introduction)
                            
                            Spacer()
                                .frame(height: 30)
                            
                            Text("스터디원을 소개합니다!")
                                .font(.pretendard(weight: .bold, size: 20))
                            
                            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                                ForEach(viewModel.study.currentMembers, id: \.self) { member in
                                    memberView2(member: member)
                                }
                                
                                ForEach(Array(viewModel.study.requiredCountPerFieldDic()), id: \.key) { field, count in
                                    ForEach(0..<count) { _ in
                                        newMemberView(field: field)
                                    }
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(.vertical, 30)
                    .padding(.horizontal, 32)
                }
                .frame(height: UIScreen.main.bounds.height - 230)
            }
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct MyStudyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyStudyDetailView()
            .environmentObject(StudyViewModel())
    }
}

struct newMemberView: View {
    var field: Field
    
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .scaledToFit()
                    .clipShape(Circle())
                    .foregroundColor(.yellow)
                
                Text("New!")
                    .font(.pretendard(weight: .bold, size: 15))
            }
            
            Text("모집중!")
                .font(Font.system(size: 20, weight: .bold))
                .foregroundColor(.black)
            
            Text(field.rawValue)
                .font(Font.system(size: 14, weight: .regular))
                .foregroundColor(.gray)
        }
    }
}

struct memberView2: View {
    var member: Member
    
    var body: some View {
        VStack {
            Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .scaledToFit()
                .clipShape(Circle())
                .foregroundColor(.gray)
            
            Text(member.user.username)
                .font(Font.system(size: 20, weight: .bold))
                .foregroundColor(.black)
            
            Text(member.field.rawValue)
                .font(Font.system(size: 14, weight: .regular))
                .foregroundColor(.gray)
        }
    }
}

