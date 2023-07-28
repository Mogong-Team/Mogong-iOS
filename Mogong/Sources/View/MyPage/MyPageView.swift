//
//  UserView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/14.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var viewModel: UserViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            UserInfo()
                .padding(.bottom, 20)
            UserBadge()
            Spacer()
        }
        .padding(.horizontal, 20)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                NavigationLink {
                    SettingView()
                } label: {
                    Image(systemName: "gearshape.fill")
                }
            }
        }
    }
}

struct UserInfo: View {
    @EnvironmentObject var viewModel: UserViewModel
    
    var body: some View {
        HStack(spacing: 10) {
            Image(viewModel.currentUser.userimageString)
                .resizable()
                .frame(width: 92, height: 92)
            
            VStack(alignment: .leading) {
                RoundRectangleText(text: "Level 1", background: Color.member)
                Text(viewModel.currentUser.username)
                    .font(.pretendard(weight: .bold, size: 28))
                    .foregroundColor(Color(hexColor: "4E4E4E"))
            }
        }
    }
}

struct UserBadge: View {
    @EnvironmentObject var viewModel: UserViewModel
    @State var presentBookmarkView: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("나의 뱃지")
                        .font(.pretendard(weight: .bold, size: 24))
                        .foregroundColor(Color(hexColor: "615B5B"))
                    Text("뽐내고 싶은 뱃지를 선택하세요!")
                        .font(.pretendard(weight: .regular, size: 14))
                        .foregroundColor(Color(hexColor: "ABA5A5"))
                }
                Spacer()
                HStack {
                    Image(systemName: "bookmark.fill")
                        .resizable()
                        .frame(width: 7, height: 10)
                        .foregroundColor(Color.main)
                    Text("스크랩 스터디")
                        .font(.pretendard(weight: .semiBold, size: 12))
                        .foregroundColor(Color(hexColor: "545454"))
                        .onTapGesture {
                            presentBookmarkView = true
                        }
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .overlay {
                    RoundedRectangle(cornerRadius: 23)
                        .stroke(Color(hexColor: "8FD0FF"), lineWidth: 1)
                }
            }
            .padding(.bottom, 20)
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 30) {
                Badge(name: "스터디 비기너")
                Badge(name: "스터디 창립자")
                Badge(name: "스터디 가입자")
                Badge(name: "스터디 출석자")
                Badge(name: "트리플 출석자")
                Badge(name: "스터디 완주자")
                Badge(name: "두번째 완주자")
                Badge(name: "세번째 완주자")
                Badge(name: "네번쨰 완주자")
            }
        }
        .navigationDestination(isPresented: $presentBookmarkView) {
            BookmarkView()
        }
    }
}

struct Badge: View {
    var name: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image("Polygon")
            Text(name)
                .font(.pretendard(weight: .semiBold, size: 16))
                .foregroundColor(Color(hexColor: "545454"))
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
            .environmentObject(UserViewModel())
    }
}
