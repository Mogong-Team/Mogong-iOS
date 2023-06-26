//
//  SelectLanguageView.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/26.
//

import SwiftUI

struct SelectLanguageView: View {
    @Environment(\.dismiss) var dismiss
 
    @Binding var selectedLanguage: Set<Language>
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(Language.allCases, id: \.self) { language in
                    SelectButton(title: language.rawValue, state: selectedLanguage.contains(language) ? .selected : .unselected) {
                        if selectedLanguage.contains(language) {
                            selectedLanguage.remove(language)
                        } else {
                            selectedLanguage.insert(language)
                        }
                    }
                }
            }
            .padding(10)
        }
        .padding(.horizontal, 20)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                }
            }
            
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
        }
    }
}
