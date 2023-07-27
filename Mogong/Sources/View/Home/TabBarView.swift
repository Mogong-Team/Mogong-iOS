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
                TempHomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            NavigationStack {
                StudyListView()
            }
            .tabItem {
                Label("Study List", systemImage: "doc.text")
            }
            
            NavigationStack {
                MyStudyView()
            }
            .tabItem {
                Label("My Study", systemImage: "pencil")
            }
            
            NavigationStack {
                UserView()
            }
            .tabItem {
                Label("My Page", systemImage: "person")
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
