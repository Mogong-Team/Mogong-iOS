//
//  ContentView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    init() {
        let navBarAppearence = UINavigationBarAppearance()
        navBarAppearence.backgroundColor = .white
        
        UINavigationBar.appearance().standardAppearance = navBarAppearence
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearence
        navBarAppearence.shadowColor = .clear
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .white
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().tintColor = .red
        UITabBar.appearance().barTintColor = .red
        UITabBar.appearance().unselectedItemTintColor = .red
        tabBarAppearance.shadowColor = .clear
    }
    
    var body: some View {
        Group {
            if authViewModel.isLoggedIn {
                TabView {
                    Group {
                        NavigationStack {
                            TempHomeView()
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
                }
                .accentColor(.black)
            } else {
                AuthView()
            }
        }
        .onAppear {
            authViewModel.checkIfLoggedIn()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
            .environmentObject(StudyViewModel())
            .environmentObject(RankViewModel())
            .environmentObject(UserViewModel())
    }
}
