//
//  Font+Pretendard.swift
//  Mogong
//
//  Created by 심현석 on 2023/06/29.
//

import SwiftUI

extension Font {
    enum PretendardWeight: String {
        case black
        case extraBold
        case bold
        case semiBold
        case medium
        case regular
        case light
        case extraLight
        case thin
        
        var name: String {
            rawValue.capitalized
        }
        
        var fontName: String {
            "Pretendard-\(name)"
        }
    }
    
    static func pretendard(weight: PretendardWeight, size: CGFloat) -> Font {
        .custom(weight.fontName, fixedSize: size)
    }
}

// MARK: - Test

fileprivate struct FontTestView: View {
    var body: some View {
        VStack {
            Text("Pretendard-Black")
                .font(.pretendard(weight: .black, size: 20))
            Text("Pretendard-ExtraBold")
                .font(.pretendard(weight: .extraBold, size: 20))
            Text("Pretendard-SemiBold")
                .font(.pretendard(weight: .semiBold, size: 20))
            Text("Pretendard-Bold")
                .font(.pretendard(weight: .bold, size: 20))
            Text("Pretendard-Medium")
                .font(.pretendard(weight: .medium, size: 20))
            Text("Pretendard-Regular")
                .font(.pretendard(weight: .regular, size: 20))
            Text("Pretendard-Light")
                .font(.pretendard(weight: .light, size: 20))
            Text("Pretendard-ExtraLight")
                .font(.pretendard(weight: .extraLight, size: 20))
            Text("Pretendard-Thin")
                .font(.pretendard(weight: .thin, size: 20))
        }
    }
}

struct FontTestView_Previews: PreviewProvider {
    static var previews: some View {
        FontTestView()
    }
}
