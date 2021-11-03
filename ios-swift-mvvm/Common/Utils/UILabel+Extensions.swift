//
//  UILabel+Extensions.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 27/10/21.
//

import UIKit

extension UILabel {
    
    func setShadow(color: CGColor, size: CGSize, opacity: Float, radius: CGFloat) {
        self.layer.shadowOffset = size
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color
    }
    
    func setDynamic(to minimum: CGFloat = 0.5) {
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = minimum
    }
    
}
