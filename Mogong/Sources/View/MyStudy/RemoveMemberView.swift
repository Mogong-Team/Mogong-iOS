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
    @Binding var study: Study2
    @State private var showRemoveReason: Bool = false
    @State private var selectedMember: String?
    
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
                RemoveMember(study: $study, selectedMember: $selectedMember)
                Spacer()
                SelectButton(title: "다음", state: selectedMember == nil ? .unselected : .selected) {
                    showRemoveReason = true
                    
                    if let memberId = selectedMember {
                        study.currentMembers.removeAll{ $0.user.id == memberId }
                    }
                }
                .disabled(selectedMember == nil)
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
    @Binding var study: Study2
    @Binding var selectedMember: String?
    
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 30) {
            ForEach(study.currentMembers.filter { $0 != study.host }, id: \.self) { member in
                HStakTeamMemberView(
                    member: member,
                    isSelected: selectedMember == member.user.id,
                    isHost: false
                )
                .onTapGesture {
                    if selectedMember == member.user.id {
                        selectedMember = nil
                    } else {
                        selectedMember = member.user.id
                    }
                }
            }
        }
    }
}
