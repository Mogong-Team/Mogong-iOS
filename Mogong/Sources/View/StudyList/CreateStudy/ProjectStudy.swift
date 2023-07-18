//
//  ProjectStudy.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/18.
//

import SwiftUI

struct ProjectStudy: View {
    @State private var selectedHostPosition: Field?
    @State private var totalMemberCount: Int = 0
    @State private var backendMemberCount: Int = 0
    @State private var frontendMemberCount: Int = 0
    @State private var designerMemberCount: Int = 0
    @State private var iosMemberCount: Int = 0
    @State private var aosMemberCount: Int = 0
    @State private var selectProfitGoal: ProfitGoal?
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("나의 사용 언어")
                Spacer()
                Text("Java")
            }
            
            HStack {
                Text("나의 포지션")
                Spacer()
                Text("프론트엔드")
            }
            
            HStack {
                Text("모집 인원")
                Spacer()
                Text("0명")
            }
            
            VStack(spacing: 16) {
                ProjectStudySelectMemberCount(memberCount: $backendMemberCount)
                ProjectStudySelectMemberCount(memberCount: $frontendMemberCount)
                ProjectStudySelectMemberCount(memberCount: $designerMemberCount)
                ProjectStudySelectMemberCount(memberCount: $iosMemberCount)
                ProjectStudySelectMemberCount(memberCount: $aosMemberCount)
            }
            ProjectStudySelectProfitGoal()
            Spacer()
            
            SelectButton(title: "완료", state: .selected) {
                
            }
        }
        .navigationTitle("스터디 생성: 프로젝트형")
        .navigationBarTitleDisplayMode(.large)
        .padding(.horizontal, 20)
    }
}

struct ProjectStudySelectMemberCount: View {
    @Binding var memberCount: Int
    let countArr = [0, 1, 2, 3, 4, 5]
    
    var body: some View {
        Group {
            HStack {
                Text("프론트엔드")
                    .font(.pretendard(weight: .bold, size: 18))
                    .foregroundColor(Color(hexColor: "727272"))
                Spacer()
                Menu {
                    ForEach(0...countArr.count, id: \.self) { count in
                        Button {
                            memberCount = count
                        } label: {
                            if count == 0 {
                                Text("필요 없음")
                            } else {
                                Text("\(String(count))명")
                            }
                        }
                    }
                } label: {
                    HStack {
                        if memberCount == 0 {
                            Text("인원수")
                            Image(systemName: "arrowtriangle.down.fill")
                                .resizable()
                                .frame(width: 12, height: 8)
                        } else {
                            Text("\(memberCount)명")
                        }
                    }
                    .font(.pretendard(weight: .bold, size: 18))
                    .foregroundColor(.white)
                    .frame(width: 95, height: 33)
                    .background(Color(hexColor: "B9CBF6"))
                    .cornerRadius(8)
                }
            }
            .padding()
        }
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hexColor: "E7EEFF"))
        }
    }
}

struct ProjectStudySelectProfitGoal: View {
    @State private var isProfitable: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("수익화 목적")
            HStack(spacing: 6) {
                Text("있음")
                    .font(.pretendard(weight: .bold, size: 18))
                    .foregroundColor(isProfitable ? .white : Color(hexColor: "D9D9D9"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 46)
                    .background(isProfitable ? Color(hexColor: "00C7F4") : .white)
                    .cornerRadius(9)
                    .overlay {
                        if !isProfitable {
                            RoundedRectangle(cornerRadius: 9)
                                .stroke(Color(hexColor: "E7EEFF"), lineWidth: 2)
                        }
                    }
                    .onTapGesture {
                        isProfitable = true
                    }
                
                Text("없음")
                    .font(.pretendard(weight: .bold, size: 18))
                    .foregroundColor(!isProfitable ? .white : Color(hexColor: "D9D9D9"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 46)
                    .background(!isProfitable ? Color(hexColor: "00C7F4") : .white)
                    .cornerRadius(9)
                    .overlay {
                        if isProfitable {
                            RoundedRectangle(cornerRadius: 9)
                                .stroke(Color(hexColor: "E7EEFF"), lineWidth: 2)
                        }
                    }
                    .onTapGesture {
                        isProfitable = false
                    }
            }
        }
    }
}

struct ProjectStudy_Previews: PreviewProvider {
    static var previews: some View {
        ProjectStudy()
    }
}
