//
//  MenuItemCell.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 28/10/21.
//

import UIKit

class MenuItemCell: UICollectionViewCell {
    
    /// Cell Reuse Identifier
    static let identifier = "MenuItemCell"
    
    /// Properties
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppins(ofSize: 32, weight: .medium)
        label.textColor = .black
        label.text = "adas"
        return label
    }()
    
    /// Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildCell()
        addLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Cell configuration
    private func buildCell() {
        contentView.addSubview(label)
    }
    
    private func addLayout() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
    func configureWith(title: String) {
        self.label.text = title
    }
}
