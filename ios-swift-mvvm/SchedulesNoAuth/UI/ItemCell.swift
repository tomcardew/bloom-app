//
//  ItemCell.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 20/10/21.
//

import UIKit

class ItemCell: UICollectionViewCell {
    /// Cell Reuse Identifier
    static let identifier = "ItemCell"
    
    private lazy var view: ScheduleItemView = {
        let view = ScheduleItemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Cell Model
    struct Model {
        let name: String
        let price: Float
        let discount: Int
        let image: String
        
        var url: URL? {
            return URL(string: image.replacingOccurrences(of: "http:", with: "https:"))
        }
    }
    
    
    
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
        addSubview(view)
    }
    
    private func addLayout() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    func configureWith(_ model: Model) {
        
    }
    
}

private extension ItemCell {
    enum DesignConstants {
        static let itemNameFontSize: CGFloat = 18.0
        static let itemPriceFontSize: CGFloat = 16.0
        static let labelMargin: CGFloat = 8.0
    }
}
