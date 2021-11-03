//
//  MenuItem.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 03/11/21.
//

import UIKit

class ProfileMenuItem: UIView {
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppins(ofSize: 28, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        buildView()
        addLayout()
    }
    
    /// Cell configuration
    private func buildView() {
        self.addSubview(imageView)
        self.addSubview(titleView)
    }
    
    private func addLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    public func configure(text: String, image: UIImage) {
        self.imageView.image = image
        self.titleView.text = text
    }
    
}
