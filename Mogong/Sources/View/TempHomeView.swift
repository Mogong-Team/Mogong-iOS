//
//  TempHomeView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI

struct TempHomeView: View {
    var body: some View {
        VStack {
            NavigationLink {
                StudyDetailView()
            } label: {
                Text("Study")
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Text("Mogong")
                    .font(.title2)
                    .fontWeight(.heavy)
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                NavigationLink {
                    ChatListView()
                } label: {
                    Image(systemName: "paperplane")
                        .tint(.black)
                }
                
                NavigationLink {
                    AlarmView()
                } label: {
                    Image(systemName: "bell")
                        .tint(.black)
                }
            }
        }
    }
}

struct TempHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TempHomeView()
    }
}
