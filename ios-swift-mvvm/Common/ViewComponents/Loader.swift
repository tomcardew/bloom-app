//
//  Loader.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 04/11/21.
//

import UIKit

class Loader: UIView {
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.setBlur()
        return view
    }()
    
    private lazy var loader: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        view.style = .large
        view.color = .black
        return view
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        setupLayout()
        setupActions()
    }
    
    // MARK: - Configuration
    private func setupViews() {
        
        self.backgroundColor = .clear
        
        self.addSubview(view)
        self.view.addSubview(loader)
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            view.heightAnchor.constraint(equalToConstant: 100),
            view.widthAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            loader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    private func setupActions() {
        
    }

}
