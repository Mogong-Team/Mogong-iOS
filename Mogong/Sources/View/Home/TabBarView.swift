//
//  TabBarView.swift
//  Mogong
//
//  Created by 예강이다 on 2023/07/08.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            NavigationStack {
//                TempHomeView()
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            NavigationStack {
                StudyListView()
            }
            .tabItem {
                Image(systemName: "doc.text")
                Text("Study List")
            }
            
            NavigationStack {
                MyStudyView()
            }
            .tabItem {
                Image(systemName: "pencil")
                Text("My Study")
            }
            
            NavigationStack {
                UserView()
            }
            .tabItem {
                Image(systemName: "person")
                Text("My Page")
            }
        }
//        .Style(DefaultTabBarStyle())
        .frame(height: 47)
        .edgesIgnoringSafeArea(.bottom) // Safe Area의 아래 여백 무시
//        .border(Color.red)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
