//
//  HomeView.swift
//  Mogong
//
//  Created by 예강이다 on 2023/07/04.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                // 메뉴바
                MenuBar()
                
                ScrollView {
                    // 방금 완주한 스터디 영역
                    CompletedStudy()
                    
                    // 스크랩이 많은 스터디 영역
                    ClippyStudy()
                }
            }
        }
    }
}

struct MenuBar: View {
    var body: some View {
        VStack {

        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Text("Mogong")
                    .font(.title2)
                    .fontWeight(.heavy)
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                NavigationLink {
                    ChatListView()
                } label: {
                    Image(systemName: "paperplane")
                        .tint(.black)
                }
                
                NavigationLink {
                    AlarmView()
                } label: {
                    Image(systemName: "bell")
                        .tint(.black)
                }
            }
        }
//        VStack {
//            HStack {
//                Text("MOGONG")
//                    .font(.title)
//                Spacer()
//
//
//                HStack {
//                    // 채팅 버튼
//                    Button(action: {
//                        // 메뉴 버튼 액션 처리
//                    }) {
//                        Image(systemName: "paperplane")
//                            .font(.title)
//                    }
//                    // 알림 버튼
//                    NavigationLink {
//                        AlarmView()
//                    } label: {
//                        Image(systemName: "bell")
//                            .tint(.black)
//                    }
//                }
//            }
//            .padding()
//            .background(Color.gray)
//            .foregroundColor(.black)
//        }
    }
}

// 완주한 스터디
struct CompletedStudy: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("방금 완주한 스터디")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("방금 완주한 따끈따끈한 스터디 목록을 살펴보세요!")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(1...10, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 250, height: 300)
                            .foregroundColor(Color.gray)
                            .overlay(
                                Text("한달동안\n프론트엔드\n스터디 같이 해요")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .padding(.top, 100)
                            )
                    }
                }
            }
        }
        .padding(.top, 30)
        .padding()
    }
}

/*
 스크랩 많은 스터디
 */
struct ClippyStudy: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("스크랩이 많은 스터디")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("관심 집중 스터디에요!")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(1...5, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 350, height: 100)
                            .foregroundColor(Color.gray)
                            .overlay(
                                Text("Study \(index)")
                                    .foregroundColor(.white)
                                    .font(.title)
                            )
                    }
                }
            }
        }
        .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


