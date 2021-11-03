//
//  UINavigationController+Extension.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 28/10/21.
//

import UIKit

extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
