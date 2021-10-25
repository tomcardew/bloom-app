//
//  BigButton.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 25/10/21.
//

import UIKit

protocol BigButtonDelegate: AnyObject {
    func didPressButton() -> Void
}

class BigButton: UIView {

    var delegate: BigButtonDelegate?
    
    var title: String = "" {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    // MARK: Properties
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = DesignConstants.textColor
        label.textAlignment = .center
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
        setupViews()
        setupLayout()
        setupActions()
    }
    
    // MARK: - Configuration
    public func configure(with model: ScheduleModel) {
        
    }
    
    private func setupViews() {
        self.backgroundColor = DesignConstants.bgColor
        self.layer.cornerRadius = 10
        self.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setupActions() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pressed))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
    }
    
    @objc func pressed() {
        self.delegate?.didPressButton()
    }

}

private extension BigButton {
    private enum DesignConstants {
        static let textColor: UIColor = .white
        static let bgColor: UIColor = .bloom_pink
    }
}
