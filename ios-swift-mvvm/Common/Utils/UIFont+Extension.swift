//
//  UIFont+Extension.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 27/10/21.
//

import UIKit

extension UIFont {
    
    enum WeightSize {
        case bold
        case medium
        case regular
        case light
    }
    
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, """
        Failed to load the "\(name)" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """)
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    static func poppins(ofSize size: CGFloat, weight: WeightSize) -> UIFont {
        switch weight {
        case .bold:
            return customFont(name: "Poppins-Bold", size: size)
        case .medium:
            return customFont(name: "Poppins-Medium", size: size)
        case .regular:
            return customFont(name: "Poppins-Regular", size: size)
        case .light:
            return customFont(name: "Poppins-Light", size: size)
        }
    }
    
}
