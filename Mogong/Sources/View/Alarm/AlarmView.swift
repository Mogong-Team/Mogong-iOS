//
//  AlarmView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/28.
//

import SwiftUI

struct AlarmView: View {
    
    var alarms = ["1", "2", "3"]
    
    var body: some View {
        VStack {
//            ScrollView {
//                VStack {
//                    ForEach(alarms, id: \.self) { alarm in
//                        AlarmCell()
//                    }
//                }
//            }

            Text("알람이 없습니다.")
            .font(.pretendard(weight: .semiBold, size: 18))
        }
        .padding(.horizontal, 20)
        .navigationTitle("알림")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
    }
}
