//
//  HeaderView.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 25/10/21.
//

import UIKit

protocol HeaderDelegate: AnyObject {
    func didPressMenu() -> Void
}

class HeaderView: UIView {
    
    var delegate: HeaderDelegate?
    
    // MARK: Properties
    private lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "LogoBig")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Menu"), for: .normal)
        return button
    }()
    
    private lazy var userButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "User"), for: .normal)
        return button
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
        self.addSubview(logoImage)
        self.addSubview(menuButton)
        self.addSubview(userButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            logoImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            logoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            logoImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            menuButton.widthAnchor.constraint(equalToConstant: 30),
            menuButton.heightAnchor.constraint(equalToConstant: 30),
            menuButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            menuButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            userButton.widthAnchor.constraint(equalToConstant: 30),
            userButton.heightAnchor.constraint(equalToConstant: 30),
            userButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            userButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupActions() {
        menuButton.addTarget(self, action: #selector(menuClicked), for: .touchUpInside)
    }
    
    @objc func menuClicked() {
        self.delegate?.didPressMenu()
    }

}

private extension HeaderView {
    private enum DesignConstants {
        
    }
}
