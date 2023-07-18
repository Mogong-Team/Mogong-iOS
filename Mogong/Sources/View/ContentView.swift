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
                .border(Color.red)
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
