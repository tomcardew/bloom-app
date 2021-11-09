//
//  Color+Extension.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 25/10/21.
//

import UIKit

extension UIColor {
    static var bloom_gray = #colorLiteral(red: 0.29, green: 0.31, blue: 0.34, alpha: 1.00)
    static var bloom_pink = #colorLiteral(red: 0.97, green: 0.71, blue: 0.65, alpha: 1.00)
    static var bloom_blue = #colorLiteral(red: 0.47, green: 0.55, blue: 0.65, alpha: 1.00)
    
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}
