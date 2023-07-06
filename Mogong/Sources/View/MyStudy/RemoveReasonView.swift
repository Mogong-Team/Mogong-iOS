//
//  RemoveReasonView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/06.
//

import SwiftUI

struct RemoveReasonView: View {
    @EnvironmentObject private var studyViewModel: StudyViewModel
    @EnvironmentObject private var userViewModel: UserViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedReason: String? = nil
    @State private var reasonText: String = ""
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("내보내기")
                        .font(.pretendard(weight: .semiBold, size: 24))
                    Text("최대 한명 선택 가능합니다.")
                        .font(.pretendard(weight: .medium, size: 18))
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            RemoveReasonCheck(selectedReason: $selectedReason)
            MultiLineTextField(text: $reasonText, placeHolder: "기타 사유를 입력해주세요.")
            SelectButton(title: "강퇴하기", state: selectedReason == nil ? .unselected : .selected) {
                studyViewModel.myStudyshowRemoveSheet = false
            }
            .disabled(selectedReason == nil)
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: NaviBackButton())
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Image(systemName: "xmark")
                    .onTapGesture {
                        studyViewModel.myStudyshowRemoveSheet = false
                    }
            }
        }
    }
}

struct RemoveReasonCheck: View {
    @Binding var selectedReason: String?
    var reasons = ["활동 중 잠수", "잦은 지각", "분란을 일으킴", "상업적 광고", "기타 사유",]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(), GridItem()]) {
                ForEach(reasons, id: \.self) {reason in
                    HStack {
                        RemoveReasonCheckButton(reason: reason, isChecked: selectedReason == reason)
                            .onTapGesture {
                                if selectedReason == reason {
                                    selectedReason = nil
                                } else {
                                    selectedReason = reason
                                }
                            }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct RemoveReasonCheckButton: View {
    var reason: String
    var isChecked: Bool
    
    var unselectedBox: Image {
        return Image(systemName: "circle")
    }
    
    var selectedBox: Image {
        return Image(systemName: "checkmark.circle.fill")
    }
    
    var body: some View {
        HStack {
            (isChecked ? selectedBox : unselectedBox)
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundColor(isChecked ? .red : .gray)
            
            Text(reason)
                .font(.pretendard(weight: .medium, size: 16))
        }
    }
}
            
