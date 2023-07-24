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
        
        navBarAppearence.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        
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
                NavigationView {
                    VStack {
                        TopBarView()
                        
                        ScrollView {
                            CompletedStudyView()
                            ClippyStudyView()
                        }
                        
                        TabBarView()
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
