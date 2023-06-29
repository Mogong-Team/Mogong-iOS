//
//  MyStudyView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/21.
//

import SwiftUI

enum MyStudyType: Int {
    case ongoing = 0
    case completed = 1
}

struct MyStudyView: View {
    @State private var type: MyStudyType = .ongoing
    
    var body: some View {
        VStack {
            HStack {
                SelectButton(title: "진행중인 스터디", state: .selected) {
                    
                }
                
                SelectButton(title: "완주한 스터디", state: .unselected) {
                    
                }
            }
            
            VStack {
                
            }
        }
    }
}

struct MyStudyCell: View {
    
    var body: some View {
        VStack {
            Image(systemName: "crown.fill")
            
            Text("한달동안 스터디 같이해요")
            
            Divider()
            
            
        }
    }
}

struct MyStudyBottomView: View {
    @Binding var type: MyStudyType
    
    var body: some View {
        VStack {
            
        }
    }
}

struct MyStudyView_Previews: PreviewProvider {
    static var previews: some View {
        MyStudyView()
    }
}

