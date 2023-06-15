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
                        Text("게시판")
                    }
                    
                    NavigationView {
                        RankView()
                    }
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("리그")
                    }
                    
                    NavigationView {
                        UserView()
                    }
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("추가")
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
