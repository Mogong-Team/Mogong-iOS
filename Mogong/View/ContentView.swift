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
    
    var body: some View {
        Group {
            if authViewModel.isLoggedIn {
                TabView {
                    NavigationView {
                        HomeView()
                    }
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Home")
                    }
                    
                    NavigationView {
                        StudyListView()
                    }
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Study List")
                    }
                    
                    NavigationView {
                        MyStudyView()
                    }
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("My Study")
                    }
                    
                    NavigationView {
                        RankView()
                    }
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Ranking")
                    }
                    
                    NavigationView {
                        UserView()
                    }
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("My Page")
                    }
                }
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
