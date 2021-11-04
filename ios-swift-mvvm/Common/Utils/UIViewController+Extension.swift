//
//  UIViewController+Extension.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 04/11/21.
//

import UIKit

extension UIViewController {
    
    func showLoader() {
        let loader = Loader()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.layer.opacity = 0
        self.view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.topAnchor.constraint(equalTo: self.view.topAnchor),
            loader.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            loader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loader.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            loader.layer.opacity = 1
        }, completion: nil)
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            if let subview = self.view.subviews.first(where: { $0 is Loader }) {
                let loader = subview as? Loader
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    loader?.layer.opacity = 0
                }, completion: { complete in
                    loader?.removeFromSuperview()
                })
            }
        }
    }
    
    func showAlert(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
