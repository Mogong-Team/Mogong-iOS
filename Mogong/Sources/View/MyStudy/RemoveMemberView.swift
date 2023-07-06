//
//  RemoveMemberView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/06.
//

import SwiftUI

struct RemoveMemberView: View {
    @EnvironmentObject private var studyViewModel: StudyViewModel
    @EnvironmentObject private var userViewModel: UserViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showRemoveReason: Bool = false
    @State private var selectedMemberId: String? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("내보내기")
                            .font(.pretendard(weight: .semiBold, size: 24))
                            .padding(.bottom, 2)
                        Text("최대 한명 선택 가능합니다.")
                            .font(.pretendard(weight: .medium, size: 18))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.bottom, 37)
                RemoveMember(selectedMemberId: $selectedMemberId)
                Spacer()
                SelectButton(title: "다음", state: selectedMemberId == nil ? .unselected : .selected) {
                    showRemoveReason = true
                }
                .disabled(selectedMemberId == nil)
            }
            .padding(.horizontal, 20)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Image(systemName: "xmark")
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
            .navigationDestination(isPresented: $showRemoveReason) {
                RemoveReasonView()
            }
        }
    }
}

struct RemoveMember: View {
    @EnvironmentObject private var studyViewModel: StudyViewModel
    @EnvironmentObject private var userViewModel: UserViewModel
    @Binding var selectedMemberId: String?
    
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 30) {
            ForEach(studyViewModel.studys[studyViewModel.myStudySelectedStudyIndex].currentMembers, id: \.self) { member in
                HStakTeamMemberView(member: member, isSelected: member.user.id == selectedMemberId)
                    .onTapGesture {
                        if selectedMemberId == member.user.id {
                            selectedMemberId = nil
                        } else {
                            selectedMemberId = member.user.id
                        }
                    }
            }
        }
    }
}
