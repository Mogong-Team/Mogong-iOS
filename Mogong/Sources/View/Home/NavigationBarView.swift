//
//  TopBarView.swift
//  Mogong
//
//  Created by 예강이다 on 2023/07/08.
//

import SwiftUI

struct NavigationBarView: View {
    var body: some View {
        VStack {
//            Text("Study List Arr")
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Image("nav_mogongLogo")
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
                    Image("bell_unalarmed")
                    //TODO: 알람왔을 떄 아이콘 변경
                }
            }
        }
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView()
    }
}
