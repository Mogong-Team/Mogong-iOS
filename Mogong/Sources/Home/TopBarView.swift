//
//  TopBarView.swift
//  Mogong
//
//  Created by 예강이다 on 2023/07/08.
//

import SwiftUI

struct TopBarView: View {
    var body: some View {
        VStack {
//            Text("Study List Arr")
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

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView()
    }
}
