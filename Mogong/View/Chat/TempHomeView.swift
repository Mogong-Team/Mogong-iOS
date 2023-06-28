//
//  TempHomeView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/28.
//

import SwiftUI

struct TempHomeView: View {
    @State private var isPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    ChatListView()
                } label: {
                    Text("ChatListView")
                }
            }
        }
    }
}
