//
//  ProjectStudy.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/18.
//

import SwiftUI

struct ProjectStudy: View {
    @EnvironmentObject var viewModel: StudyViewModel
    @State private var presentSheet = false
    
    var neededMemberCount: Int {
        return viewModel.positionInfos.reduce(0) { $0 + $1.requiredCount }
    }
    
    var isCompleted: Bool {
        return viewModel.hostPosition != nil
        && neededMemberCount != 0
        && viewModel.frequencyOfWeek != 0
        && viewModel.durationOfMonth != 0
    }
    
    var body: some View {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    HStack {
                        Text("나의 포지션")
                            .font(.pretendard(weight: .medium, size: 16))
                            .foregroundColor(Color(hexColor: "727272"))
                        Spacer()
                        HStack {
                            if let text = viewModel.hostPosition?.rawValue {
                                Text(text)
                                    .font(.pretendard(weight: .bold, size: 18))
                                    .foregroundColor(Color(hexColor: "727272"))
                                Image("arrow_right")
                            } else {
                                Text("포지션을 선택해 주세요!")
                                    .font(.pretendard(weight: .bold, size: 18))
                                    .foregroundColor(Color.main)
                            }
                        }
                        .onTapGesture {
                            presentSheet = true
                        }
                    }
                    
                    HStack {
                        Text("모집 인원")
                            .font(.pretendard(weight: .medium, size: 16))
                            .foregroundColor(Color(hexColor: "727272"))
                        Spacer()
                        
                        HStack {
                            Text("총 ")
                                .font(.pretendard(weight: .bold, size: 18))
                                .foregroundColor(Color(hexColor: "727272"))
                            Text("\(neededMemberCount)")
                                .font(.pretendard(weight: .bold, size: 18))
                                .foregroundColor(Color.main)
                            Text("명")
                                .font(.pretendard(weight: .bold, size: 18))
                                .foregroundColor(Color(hexColor: "727272"))
                        }
                    }
                    
                    VStack(spacing: 16) {
                        ProjectStudyPositionInfo(position: .backend)
                        ProjectStudyPositionInfo(position: .frontend)
                        ProjectStudyPositionInfo(position: .aos)
                        ProjectStudyPositionInfo(position: .ios)
                        ProjectStudyPositionInfo(position: .cross)
                        ProjectStudyPositionInfo(position: .designer)
                        ProjectStudyPositionInfo(position: .planner)
                    }
                    
                    VStack(spacing: 10) {
                        GeneralStudySelectFrequencyMenu()
                        GeneralStudySelectDurationMenu()
                        ProjectStudySelectProfitGoal()
                    }
                    
                    ActionButton("완료") {
                        if viewModel.stateForCreateStudy == .new {
                            viewModel.createStudy()
                        } else {
                            viewModel.updateStudy()
                        }
                        
                        viewModel.presentStudyDetail = false
                        viewModel.showCreateStudyOnList = false
                        viewModel.showCreateStudyOnDetail = false
                    }
                    .disabled(!isCompleted)
                }
                .padding(.top, 20)
                .padding(.bottom, 10)
                .padding(.horizontal, 20)
            }
            .navigationTitle("프로젝트형")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Image(systemName: "xmark")
                        .fontWeight(.bold)
                        .onTapGesture {
                            viewModel.showCreateStudyOnList = false
                            viewModel.showCreateStudyOnDetail = false
                        }
                }
            }
            .sheet(isPresented: $presentSheet) {
                ProjectStudyHostPositionModal()
                    .presentationDetents([.fraction(0.53)])
            }
    }
}

struct ProjectStudyPositionInfo: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    var position: Position
    @State var presentSheet = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(position.rawValue)
                    .font(.pretendard(weight: .bold, size: 18))
                    .foregroundColor(Color(hexColor: "727272"))
                Text(viewModel.setPositionInfoText(position: position))
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
        .onTapGesture {
            presentSheet = true
        }
        .sheet(isPresented: $presentSheet) {
            ProjectStudyPositionInfoModal(position: position)
                .presentationDetents([.fraction(0.8)])
        }
    }
}

struct ProjectStudySelectProfitGoal: View {
    @State private var isProfitable: Bool = false
    
    var body: some View {
        VStack {
            HStack{
                Text("수익화 목적")
                Spacer()
                
                Text("있음")
                    .font(.pretendard(weight: .bold, size: 18))
                    .foregroundColor(isProfitable ? .white : Color(hexColor: "D9D9D9"))
                    .frame(width: 80, height: 46)
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
                    .frame(width: 80, height: 46)
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
        NavigationStack {
            ProjectStudy()
        }
    }
}
