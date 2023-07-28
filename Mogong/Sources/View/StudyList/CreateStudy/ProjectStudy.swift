//
//  ProjectStudy.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/18.
//

import SwiftUI

struct ProjectStudy: View {
    @EnvironmentObject var viewModel: StudyViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
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
                    ProjectStudyPositionInfo()
                    ProjectStudyPositionInfo()
                    ProjectStudyPositionInfo()
                    ProjectStudyPositionInfo()
                    ProjectStudyPositionInfo()
                    ProjectStudyPositionInfo()
                    ProjectStudyPositionInfo()
                    ProjectStudyPositionInfo()
                }
                ProjectStudySelectProfitGoal()
                Spacer()
                
                SelectButton(title: "완료", state: .selected) {
                    // TODO: Post Study
                }
            }
        }
        .navigationTitle("스터디 생성: 프로젝트형")
        .navigationBarTitleDisplayMode(.large)
        .padding(.horizontal, 20)
    }
}

struct ProjectStudyPositionInfo: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("프론트엔드")
                    .font(.pretendard(weight: .bold, size: 18))
                    .foregroundColor(Color(hexColor: "727272"))
                Text("2명 / Swift / Vue")
                    .font(.pretendard(weight: .semiBold, size: 14))
                    .foregroundColor(Color(hexColor: "0090E1"))
            }
            Spacer()
            Image(systemName: "arrow.right")
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 12)
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color(hexColor: "CCE6FA"), lineWidth: 2)
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
                    .background(isProfitable ? Color.main : .white)
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
                    .background(!isProfitable ? Color.main : .white)
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
