//
//  RemoveReasonView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/06.
//

import SwiftUI

struct RemoveReasonView: View {
    @EnvironmentObject private var viewModel: StudyViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var reasonText: String = ""
    @State private var showDropAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
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
            .padding(.bottom, 15)
            
            VStack {
                RemoveReasonCheck()
                    .padding(.bottom, 15)
                MultiLineTextField(text: $reasonText, placeHolder: "기타 사유를 입력해주세요.")
                    .frame(height: 140)
                Spacer()
            }
            
            ActionButton("강퇴하기") {
                showDropAlert = true
            }
            .disabled(viewModel.removeReason.isEmpty)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: NaviBackButton())
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Image(systemName: "xmark")
                    .onTapGesture {
                        viewModel.showRemoveMember = false
                    }
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        .alert("강퇴하기", isPresented: $showDropAlert) {
            Button("확인") {
                viewModel.showRemoveMember = false
                viewModel.removeMember()
            }
            
            Button("취소", role: .cancel) { }
        } message: {
            Text("정말로 강퇴하시겠습니까?")
        }
    }
}

struct RemoveReasonCheck: View {
    @EnvironmentObject private var viewModel: StudyViewModel
    var reasons = ["활동 중 잠수", "잦은 지각", "분란을 일으킴", "상업적 광고", "기타 사유",]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 20) {
                ForEach(reasons, id: \.self) {reason in
                    HStack {
                        RemoveReasonCheckButton(
                            reason: reason,
                            isChecked: viewModel.removeReason == reason)
                            .onTapGesture {
                                if viewModel.removeReason == reason {
                                    viewModel.removeReason = ""
                                } else {
                                    viewModel.removeReason = reason
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
            

struct RemoveReasonView_Previews: PreviewProvider {
    static var previews: some View {
        RemoveReasonView()
            .environmentObject(StudyViewModel())
            .environmentObject(UserViewModel())
    }
}
