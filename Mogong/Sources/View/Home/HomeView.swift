//
//  HomeView.swift
//  Mogong
//
//  Created by 예강이다 on 2023/07/04.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var stduyViewModel: StudyViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        VStack {
            ScrollView {
                CompletedStudyView()
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                ClippyStudyView()
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Image("nav_mogongLogo")
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                NavigationLink {
                    ChatListView()
                } label: {
                    Image("message")
                }

                NavigationLink {
                    AlarmView()
                } label: {
                    Image("bell_unalarmed")
                    //TODO: 알람왔을 떄 아이콘 변경
                }
            }
        }
        .onAppear {
            stduyViewModel.getAllStudys()
            
            guard let user = authViewModel.currentUser else { return }
            userViewModel.currentUser = user
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
                .environmentObject(StudyViewModel())
        }
    }
}


