//
//  NaviBackButton.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/05.
//


import SwiftUI

struct NaviBackButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.black)
        }
    }
}
