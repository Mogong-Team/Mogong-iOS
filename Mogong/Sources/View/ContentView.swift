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
    @State var showingMainView = false
    
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
        ZStack {
            Group {
                if authViewModel.isLoggedIn {
                    TabBar()
                } else {
                    AuthView()
                }
                
                if !showingMainView {
                    SplashScreenView.transition(.opacity)
                }
            }
            .onAppear {
                authViewModel.checkIfLoggedIn()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                showingMainView.toggle()
                authViewModel.checkIfLoggedIn()
                authViewModel.getUser()
            })
        }
    }
}

struct TabBar: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                if selectedTab == 0 {
                    Image("home_selected")
                } else {
                    Image("home_unselected")
                }
                Text("Home")
            }
            .tag(0)
            
            NavigationStack {
                StudyListView()
            }
            .tabItem {
                if selectedTab == 1 {
                    Image("studylist_selected")
                } else {
                    Image("studylist_unselected")
                }
                Text("Study List")
            }
            .tag(1)
            
            NavigationStack {
                MyStudyView()
            }
            .tabItem {
                if selectedTab == 2 {
                    Image("mystudy_selected")
                } else {
                    Image("mystudy_unselected")
                }
                Text("My Study")
            }
            .tag(2)
            
            NavigationStack {
                UserView()
            }
            .tabItem {
                if selectedTab == 3 {
                    Image("mypage_selected")
                } else {
                    Image("mypage_unselected")
                }
                Text("Setting")
            }
            .tag(3)
        }
        .accentColor(Color.main)
    }
}

//Mark: - 스플래시 스크린
extension ContentView {
    var SplashScreenView: some View {
        Image("Splash")
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
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
