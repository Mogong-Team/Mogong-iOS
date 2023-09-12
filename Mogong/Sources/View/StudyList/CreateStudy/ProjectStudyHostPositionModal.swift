//
//  ProjectStudyHostPositionModal.swift
//  Mogong
//
//  Created by 심현석 on 2023/09/09.
//

import SwiftUI

struct ProjectStudyHostPositionModal: View {
    @EnvironmentObject var viewModel: StudyViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var position: Position?
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("한가지 포지션을 선택해 주세요.")
                    .font(.pretendard(weight: .medium, size: 16))
                    .foregroundColor(Color(hexColor: "9B9C9C"))
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                    ForEach(Position.allCases, id: \.self) { position in
                        SelectPositioinRectangle(
                            position: position,
                            selectedPosition: $position)
                    }
                }
                
                Spacer()
                
                ActionButton("포지션 선택") {
                    dismiss()
                    viewModel.hostPosition = position
                }
            }
            .padding(.horizontal, 20)
            .navigationTitle("지원 포지션")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Image(systemName: "xmark")
                        .onTapGesture {
                            dismiss()
                            resetPosition()
                        }
                }
            }
        }
    }
    
    func resetPosition() {
        position = nil
    }
}

struct ProjectStudyHostPositionModal_Previews: PreviewProvider {
    static var previews: some View {
        ProjectStudyHostPositionModal()
    }
}
