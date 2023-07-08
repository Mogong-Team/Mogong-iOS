//
//  View+hideKeyboard.swift
//  Mogong
//
//  Created by 심현석 on 2023/07/08.
//

import SwiftUI

extension View {
  func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}

