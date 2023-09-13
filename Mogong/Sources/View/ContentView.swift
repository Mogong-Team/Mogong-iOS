//
//  ContentView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var userViewModel: UserViewModel
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
        tabBarAppearance.shadowColor = .systemGray6
    }
    
    var body: some View {
        ZStack {
            Group {
                if authViewModel.signState == .signIn {
                    if authViewModel.currentUser != nil {
                        if authViewModel.currentUser?.username == "" {
                            UsernameView()
                        } else {
                            TabBar()
                        }
                    }
                } else {
                    AuthView()
                }
                
                if !showingMainView {
                    SplashScreenView.transition(.opacity)
                }
            }
        }
        .onAppear {
            if Auth.auth().currentUser != nil {
                guard let uid = Auth.auth().currentUser?.uid else { return }
                authViewModel.signState = .signIn
                authViewModel.getUser(uid: uid)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                showingMainView.toggle()
            })
        }
    }
}

struct TabBar: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                NavigationStack {
                    HomeView()
                }
                .tabItem {
                    if selectedTab == 0 {
                        Image("home_selected")
                    } else {
                        Image("home_unselected")
                    }
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
                }
                .tag(3)
            }
        }
        .tint(.black)
    }
}

//MARK: 스플래시 스크린

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
