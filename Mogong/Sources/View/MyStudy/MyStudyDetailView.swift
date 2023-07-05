//
//  MyStudyDetailView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/29.
//

import SwiftUI

enum HostMemberType {
    case host
    case member
}

struct MyStudyDetailView: View {
    
    var study: Study
        
    var viewType: HostMemberType
    
    @State private var showSecessionAlert = false
        
    var body: some View {
        ZStack {
            Color(uiColor: .lightGray)
            
            VStack {
                Spacer()
                    .frame(height: 130)
                
                Text("나의 스터디")
                    .font(.pretendard(weight: .bold, size: 28))
                    .foregroundColor(.white)
                
                Spacer()
                    .frame(height: 85)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .foregroundColor(.white)
                       
                    ScrollView {
                        VStack {
                            VStack(alignment: .leading) {
                                
                                Text("스터디 소개글")
                                    .font(.pretendard(weight: .bold, size: 20))
                                
                                Spacer()
                                    .frame(height: 15)
                                
                                Text(study.introduction)
                                
                                Spacer()
                                    .frame(height: 30)
                                
                                Text("스터디원을 소개합니다!")
                                    .font(.pretendard(weight: .bold, size: 20))
                                
                                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                                    ForEach(study.currentMembers, id: \.self) { member in
                                        NavigationLink {
                                            UserPageView()
                                        } label: {
                                            TeamMemberView(member: member, viewType: viewType)
                                        }
                                    }
                                    
                                    ForEach(Array(study.requiredCountPerFieldDic()), id: \.key) { field, count in
                                        ForEach(0..<count) { _ in
                                            NewTeamMemberView(field: field)
                                        }
                                    }
                                }
                            }
                            
                            Spacer()
                                .frame(height: 50)
                            
                            if viewType == .member {
                                Button {
                                    showSecessionAlert = true
                                } label: {
                                    Text("탈퇴하기")
                                        .font(.pretendard(weight: .regular, size: 15))
                                        .foregroundColor(.red)
                                }
                                .alert("탈퇴하기", isPresented: $showSecessionAlert) {
                                    Button("확인", role: .destructive) {
                                        // 탈퇴하기
                                    }
                                    
                                    Button("취소", role: .cancel) { }
                                } message: {
                                    Text("정말로 탈퇴하시겠습니까?")
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(.vertical, 30)
                    .padding(.horizontal, 32)
                }
                .frame(maxHeight: .infinity)
            }
        }
        .ignoresSafeArea()
        .toolbar {
            if viewType == .host {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    NavigationLink {
                        CreateStudy()
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct MyStudyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyStudyDetailView(study: StudyViewModel().study, viewType: .host)
    }
}

struct NewTeamMemberView: View {
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



