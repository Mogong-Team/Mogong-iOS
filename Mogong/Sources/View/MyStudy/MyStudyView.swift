//
//  MyStudyView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/21.
//

import SwiftUI

enum MyStudyType {
    case ongoing
    case completed
}

struct MyStudyView: View {
    @EnvironmentObject var viewModel: StudyViewModel
    
    @State private var type: MyStudyType = .ongoing
    
    var body: some View {
        VStack {
            HStack {
                SelectButton(title: "진행중인 스터디", state: .selected) {
                    type = .ongoing
                }
                
                SelectButton(title: "완주한 스터디", state: .unselected) {
                    type = .completed
                }
            }
            
            ScrollView {
                VStack {
                    ForEach(viewModel.studys.filter { type ==  .ongoing ? !$0.isStudyCompleted : $0.isStudyCompleted }, id: \.self) { study in
                        ZStack {
                            RoundedRectangle(cornerRadius: 33)
                                .frame(height: 300)
                                .foregroundColor(Color(uiColor: .systemGray6))
                            
                            if type == .ongoing {
                                MyStudyCell(study: study)
                            } else {
                                MyStudyCell(study: study)
                            }
                        }
                    }
                }
            }
        }
        .padding(20)
    }
}

struct MyStudyCell: View {
    var study: Study
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "crown.fill")
                .resizable()
                .frame(width: 45, height: 45)
                .foregroundColor(.yellow)
            
            Spacer()
            
            Text(study.title)
                .font(.pretendard(weight: .bold, size: 26))
            
            Divider()
            
            CheckLabel(text: study.studyMode.rawValue)
            CheckLabel(text: "참여인원 \(study.totalMemberCount)명 / 주 \(study.frequencyOfWeek)회(\(study.durationOfMonth)개월) 진행")
        }
        .padding(20)
    }
}

//struct MyStudyBottomView: View {
//    @Binding var type: MyStudyType
//
//    var body: some View {
//        VStack {
//
//        }
//    }
//}

struct MyStudyView_Previews: PreviewProvider {
    static var previews: some View {
        MyStudyView()
    }
}

