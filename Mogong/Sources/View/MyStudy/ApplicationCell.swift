//
//  ApplicationCell.swift
//  Mogong
//
//  Created by 심현석 on 2023/09/12.
//

import SwiftUI

struct ApplicationCell: View {
    @EnvironmentObject var viewModel: ApplicationViewModel
    
    var application: Application
    
    var body: some View {
        ZStack {
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .frame(width: 85)
                    .cornerRadius(13)
                
                Rectangle()
                    .frame(height: 120)
                    .cornerRadius(13)
            }
            .foregroundColor(Color(hexColor: "ECFBFF"))
            
            HStack {
                Spacer()
                VStack {
                    Text(application.submitDate.toDotString())
                        .font(.pretendard(weight: .medium, size: 14))
                        .foregroundColor(Color(hexColor: "494949"))
                        .padding(.trailing, 5)
                    Spacer()
                }
            }
            
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Text("#스터디비기너")
                        .font(.pretendard(weight: .bold, size: 20))
                        .foregroundColor(Color(hexColor: "9A9A9A", opacity: 0.6))
                        .padding(.bottom, 15)
                        .padding(.trailing, 15)
                }
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Image(application.user.userimageString)
                        .resizable()
                        .frame(width: 35, height: 35)
                        .scaledToFit()
                        .clipShape(Circle())
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Text(application.position.rawValue)
                        .frame(height: 22)
                        .padding(.horizontal, 8)
                        .font(.pretendard(weight: .semiBold, size: 14))
                        .foregroundColor(.white)
                        .background(Color.main)
                        .cornerRadius(7)
                    
                    Text(application.user.username)
                        .font(.pretendard(weight: .bold, size: 20))
                        .foregroundColor(Color(hexColor: "494949"))
                }
                .padding(.top, 15)
                .padding(.bottom, 15)
                .padding(.leading, 15)
                Spacer()
            }
        }
        .frame(height: 140)
    }
}

struct ApplicationCell_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationCell(application: Application.application1)
    }
}
