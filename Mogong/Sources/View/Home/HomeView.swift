//
//  HomeView.swift
//  Mogong
//
//  Created by 예강이다 on 2023/07/04.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack {
            NavigationBarView()
            
            ScrollView {
                CompletedStudyView()
                ClippyStudyView()
            }
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


