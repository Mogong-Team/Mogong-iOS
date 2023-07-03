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
        VStack {
            Spacer()
                .frame(height: 50)
            
            HStack {
                NavigationLink {
                    SettingView()
                } label: {
                    Text(viewModel.currentUser.username)
                        .font(.pretendard(weight: .bold, size: 28))
                    
                    Image(systemName: "gearshape.fill")
                }
                .foregroundColor(.black)
                
                Spacer()
            }
            
            Spacer()
                .frame(height: 20)
            
            HStack {
                NavigationLink {
                    BookmarkView()
                } label: {
                    Image(systemName: "bookmark.fill")
                        .foregroundColor(.yellow)
                    
                    Text("스크랩 스터디")
                        .font(.pretendard(weight: .regular, size: 15))
                        .foregroundColor(.black)
                }
                                
                Spacer()
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
            .environmentObject(UserViewModel())
    }
}
