//
//  PolicyView.swift
//  Mogong
//
//  Created by 심현석 on 2023/09/14.
//

import SwiftUI
import WebKit

struct PolicyView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let filePath = Bundle.main.path(forResource: "개인정보처리방침", ofType: "html") else {
            print("filePath 오류")
            return
        }
        let url = URL(fileURLWithPath: filePath)
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    class Coordinator { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
}
