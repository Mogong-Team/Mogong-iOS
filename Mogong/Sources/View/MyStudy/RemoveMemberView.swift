//
//  RemoveMemberView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/06.
//

import SwiftUI

struct RemoveMemberView: View {
    @EnvironmentObject private var viewModel: StudyViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var showRemoveReason: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("내보내기")
                        .font(.pretendard(weight: .semiBold, size: 24))
                        .foregroundColor(Color(hexColor: "1D1C1C"))
                        .padding(.bottom, 2)
                    Text("최대 한명 선택 가능합니다.")
                        .font(.pretendard(weight: .medium, size: 18))
                        .foregroundColor(Color(hexColor: "868686"))
                }
                Spacer()
            }
            .padding(.bottom, 37)
            
            RemoveMember()
            Spacer()
            ActionButton("다음") {
                showRemoveReason = true
            }
            .disabled(viewModel.selectedMember == nil)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
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

struct RemoveMember: View {
    @EnvironmentObject private var viewModel: StudyViewModel
    
    var body: some View {
        LazyVGrid(columns: [GridItem(), GridItem()], spacing: 30) {
            ForEach(viewModel.selectedStudy.currentMembers.filter { $0.user.id != viewModel.selectedStudy.host.id }, id: \.self) { member in
                HStakTeamMemberView(
                    member: member,
                    isSelected: viewModel.selectedMember?.user.id == member.user.id,
                    isHost: false
                )
                .onTapGesture {
                    if viewModel.selectedMember?.user.id == member.user.id {
                        viewModel.selectedMember = nil
                    } else {
                        viewModel.selectedMember = member
                    }
                }
            }
        }
    }
}

struct RemoveMemberView_Previews: PreviewProvider {
    static var previews: some View {
        RemoveMemberView()
            .environmentObject(StudyViewModel())
            .environmentObject(UserViewModel())
    }
}
