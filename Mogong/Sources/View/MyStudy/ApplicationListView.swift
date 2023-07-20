//
//  ApplicationListView.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/10.
//

import SwiftUI

struct ApplicationListView: View {
    @EnvironmentObject var viewModel: ApplicationViewModel
    
    var user: User
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("지원자 리스트")
                            .font(.pretendard(weight: .semiBold, size: 24))
                            .padding(.bottom, 2)
                        Text("내 스터디에 지원한 지원자들을 살펴보시고\n가입 여부를 결정해 주세요!")
                            .font(.pretendard(weight: .medium, size: 18))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.bottom, 45)
                
                ForEach(viewModel.applications, id: \.self) { application in
                    ApplicationList(application: application)
                }
            }
            .padding(.vertical, 10)
        }
        .padding(.horizontal, 20)
    }
}

struct ApplicationListView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationListView(user: User(id: "1", name: "김민수", email: "1@gmail.com", username: "김김민수"))
            .environmentObject(ApplicationViewModel())
    }
}

struct ApplicationList: View {
    @EnvironmentObject var viewModel: ApplicationViewModel
    
    var application: Application
    
    var body: some View {
        NavigationLink {
            ApplicationDetailView(application: application)
        } label: {
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    Rectangle()
                        .frame(width: 80, height: 20)
                    Rectangle()
                }
                .foregroundColor(Color(uiColor: .systemMint))
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Spacer()
                        Text("2023.7.3")
                    }
                    
                    HStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .scaledToFit()
                            .clipShape(Circle())
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "ellipsis")
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("프론트엔드")
                            .padding(.vertical, 3)
                            .padding(.horizontal, 5)
                            .font(.pretendard(weight: .semiBold, size: 14))
                            .foregroundColor(.white)
                            .background(.yellow)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 5)
                    
                    HStack {
                        Text("녹차라떼")
                            .font(.pretendard(weight: .bold, size: 20))
                            .foregroundColor(.white)
                        Spacer()
                        Text("#스터디비기너")
                            .font(.pretendard(weight: .bold, size: 20))
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 5)
                }
                .padding(.horizontal, 12)
            }
            .frame(height: 140)
        }
    }
}