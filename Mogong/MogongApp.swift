//
//  MogongApp.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI

@main
struct MogongApp: App {
    @StateObject var loginViewModel = LoginViewModel()
    @StateObject var studyViewModel = StudyViewModel()
    @StateObject var rankViewModel = RankViewModel()
    @StateObject var userViewModel = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loginViewModel)
                .environmentObject(studyViewModel)
                .environmentObject(rankViewModel)
                .environmentObject(userViewModel)
        }
    }
}
