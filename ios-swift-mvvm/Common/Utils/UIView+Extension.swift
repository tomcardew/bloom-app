//
//  UIView+Extension.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 04/11/21.
//

import UIKit

extension UIView {
    
    func setBlur(style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.bounds = self.bounds
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(blurEffectView)
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: self.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func onClick(target: Any?, selector: Selector?) {
        let gesture = UITapGestureRecognizer(target: target, action: selector)
        gesture.numberOfTapsRequired = 1
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
    }
    
    func needsAttention() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        Vibration.error.vibrate()
        self.layer.add(animation, forKey: "position")
    }
    
}
