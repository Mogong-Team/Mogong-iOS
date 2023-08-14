//
//  SelectPositionView.swift
//  Mogong
//
//  Created by 심현석 on 2023/08/14.
//

import SwiftUI

struct SelectPositionView: View {
    @EnvironmentObject var viewModel: ApplicationViewModel
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
                    viewModel.position = position
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

struct SelectPositioinRectangle: View {
    var position: Position
    @Binding var selectedPosition: Position?
    
    var isSelected: Bool {
        return selectedPosition == position
    }
    
    var body: some View {
        Text(position.rawValue)
            .font(.pretendard(weight: .bold, size: 18))
            .foregroundColor(isSelected
                             ? .white
                             : Color(hexColor: "504E4E"))
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(isSelected
                        ? Color.main
                        : .white)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(hexColor: "D2D6D9"), lineWidth: 1)
            }
            .onTapGesture {
                selectedPosition = position
            }
    }
}

struct SelectPositionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SelectPositionView()
                .environmentObject(ApplicationViewModel())
        }
    }
}
