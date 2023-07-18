//
//  GeneralStudy.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/18.
//

import SwiftUI

struct GeneralStudy: View {
    @State private var frequencyOfWeek: Int = 0
    @State private var durationOfMonth: Int = 0
    
    let memberCount = [2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("학습 언어 선택")
            
            VStack {
                HStack(spacing: 0) {
                    GeneralStudySelectCategory()
                    GeneralStudySelectCategory()
                }
                HStack(spacing: 0) {
                    GeneralStudySelectCategory()
                    GeneralStudySelectCategory()
                    GeneralStudySelectCategory()
                }
            }
            
            Text("언어는 3개까지 선택이 가능합니다.")
            
            VStack {
                GeneralStudySelectLanguage()
                GeneralStudySelectLanguage()
            }
            
            GeneralStudySelectFrequencyMenu(frequencyOfWeek: $frequencyOfWeek)
            GeneralStudySelectDurationMenu(durationOfMonth: $durationOfMonth)
            
            Spacer()
            
            SelectButton(title: "완료", state: .selected) {
                
            }
        }
        .navigationTitle("스터디 생성: 일반 스터디")
        .navigationBarTitleDisplayMode(.large)
        .padding(.horizontal, 20)
    }
}

struct GeneralStudySelectCategory: View {
    var body: some View {
        Text("모바일")
            .font(.pretendard(weight: .bold, size: 16))
            .frame(height: 46)
            .frame(maxWidth: .infinity)
            .cornerRadius(25)
            .overlay {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.blue, lineWidth: 2.5)
            }
    }
}

struct GeneralStudySelectLanguage: View {
    var body: some View {
        VStack {
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(.gray)
            
            Text("JavaScript")
                .font(.pretendard(weight: .bold, size: 16))
        }
    }
}

struct GeneralStudySelectFrequencyMenu: View {
    @Binding var frequencyOfWeek: Int
    let frequency = [1, 2, 3, 4, 5, 6, 7]
    
    var body: some View {
        HStack {
            Text("횟수")
                .font(Font.system(size: 16))
                .frame(height: 25)
            
            Spacer()
            
            Menu {
                ForEach(1...frequency.count, id: \.self) { frequency in
                    Button {
                        frequencyOfWeek = frequency
                    } label: {
                        Text("주 \(String(frequency))일")
                    }
                }
            } label: {
                HStack {
                    if frequencyOfWeek == 0 {
                        Text("일")
                            .foregroundColor(Color(uiColor: .lightGray))
                        
                        Image(systemName: "arrowtriangle.down.fill")
                            .foregroundColor(.gray)
                    } else {
                        Text("주 \(frequencyOfWeek)일")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                }
                .font(Font.system(size: 16))
                .padding(.horizontal, 13)
                .frame(width: 110, height: 38)
                .overlay {
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(Color.gray, lineWidth: 1)
                }
            }
        }
    }
}

struct GeneralStudySelectDurationMenu: View {
    @Binding var durationOfMonth: Int
    let month = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    
    var body: some View {
        HStack {
            Text("기간")
                .font(Font.system(size: 16))
                .frame(height: 25)
            
            Spacer()
            
            Menu {
                ForEach(1...month.count, id: \.self) { month in
                    Button {
                        durationOfMonth = month
                    } label: {
                        Text("\(String(month))달")
                    }
                }
            } label: {
                HStack {
                    if durationOfMonth == 0 {
                        Text("달")
                            .foregroundColor(Color(uiColor: .lightGray))
                        
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    } else {
                        Text("\(durationOfMonth)달")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                }
                .font(Font.system(size: 16))
                .padding(.horizontal, 13)
                .frame(width: 95, height: 38)
                .overlay {
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(Color.gray, lineWidth: 1)
                }
            }
        }
    }
}

struct GeneralStudy_Previews: PreviewProvider {
    static var previews: some View {
        GeneralStudy()
    }
}
