//
//  HomeView.swift
//  Mogong
//
//  Created by 예강이다 on 2023/07/04.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthViewModel())
            .environmentObject(StudyViewModel())
            .environmentObject(RankViewModel())
            .environmentObject(UserViewModel())
    }
}


