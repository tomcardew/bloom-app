//
//  ScheduleViewCell.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 25/10/21.
//

import UIKit

class ScheduleItemView: UIView {
    
    // MARK: - Properties
    private lazy var instructorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = DesignConstants.instructorColor
        label.text = "Instructor"
        return label
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
        self.backgroundColor = .red
        setupViews()
        setupLayout()
    }
    
    // MARK: - Configuration
    public func configure(with model: ScheduleModel) {
        
    }
    
    private func setupViews() {
        self.addSubview(instructorLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            instructorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            instructorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
}

// MARK: - Extensions
private extension ScheduleItemView {
    private enum DesignConstants {
        static let instructorColor: UIColor = .bloom_gray
    }
}
