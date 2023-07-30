////
////  MainTabView.swift
////  Mogong
////
////  Created by 예강이다 on 2023/07/30.
////
//
//import SwiftUI
//
//struct MainTabView: View {
//    @EnvironmentObject var authViewModel: AuthViewModel
//    
//    var body: some View {
//        Group {
//            if authViewModel.isLoggedIn {
//                NavigationView {
//                    TabView {
//                        HomeView()
//                            .tabItem {
//                                Label("Home", systemImage: "house")
//                            }
//                        StudyListView()
//                            .tabItem {
//                                Label("Study List", systemImage: "doc.text")
//                            }
//                        MyStudyView()
//                            .tabItem {
//                                Label("My Study", systemImage: "pencil")
//                            }
//                        UserView()
//                            .tabItem {
//                                Label("My page", systemImage: "person")
//                            }
//                    }
//                }
//            } else {
//                AuthView()
//            }
//        }
//        .onAppear {
//            authViewModel.checkIfLoggedIn()
//        }
//    }
//}
//
//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//            .environmentObject(AuthViewModel())
//            .environmentObject(StudyViewModel())
//            .environmentObject(RankViewModel())
//            .environmentObject(UserViewModel())
//    }
//}
