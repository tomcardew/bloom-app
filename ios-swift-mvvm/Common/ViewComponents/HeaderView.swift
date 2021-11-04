//
//  HeaderView.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 25/10/21.
//

import UIKit
import Nuke

protocol HeaderDelegate: AnyObject {
    func didPressMenu() -> Void
    func didPressUser() -> Void
    func didPressHome() -> Void
}

class HeaderView: UIView {
    
    var delegate: HeaderDelegate?
    
    var profilePictureUrl: String? {
        didSet {
            setProfileImage()
        }
    }
    
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
    
    private lazy var userImageButton: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.backgroundColor = .red
        image.isHidden = true
        return image
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
    public func configure(with user: User) {
        self.profilePictureUrl = user.pictureUrl
        DataManager.shared.attach(self)
    }
    
    private func setupViews() {
        self.addSubview(logoImage)
        self.addSubview(menuButton)
        self.addSubview(userButton)
        self.addSubview(userImageButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoImage.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            logoImage.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            menuButton.widthAnchor.constraint(equalToConstant: 30),
            menuButton.heightAnchor.constraint(equalToConstant: 30),
            menuButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            menuButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40)
        ])
        NSLayoutConstraint.activate([
            userButton.widthAnchor.constraint(equalToConstant: 30),
            userButton.heightAnchor.constraint(equalToConstant: 30),
            userButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            userButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
        NSLayoutConstraint.activate([
            userImageButton.widthAnchor.constraint(equalToConstant: 30),
            userImageButton.heightAnchor.constraint(equalToConstant: 30),
            userImageButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            userImageButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
    }
    
    private func setupActions() {
        menuButton.addTarget(self, action: #selector(menuClicked), for: .touchUpInside)
        userButton.addTarget(self, action: #selector(userClicked), for: .touchUpInside)
        userImageButton.onClick(target: self, selector: #selector(userClicked))
        logoImage.onClick(target: self, selector: #selector(homeClicked))
    }
    
    @objc func menuClicked() {
        self.delegate?.didPressMenu()
    }
    
    @objc func userClicked() {
        self.delegate?.didPressUser()
    }
    
    @objc func homeClicked() {
        self.delegate?.didPressHome()
    }
    
    private func setProfileImage() {
        DispatchQueue.main.async {
            self.userButton.isHidden = true
            self.userImageButton.isHidden = false
            if let pic = self.profilePictureUrl, let url = URL(string: self.profilePictureUrl!.replacingOccurrences(of: "http://", with: "https://")) {
                Nuke.loadImage(with: url, into: self.userImageButton)
            } else {
                self.userButton.isHidden = false
                self.userImageButton.isHidden = true
            }
        }
    }

}

private extension HeaderView {
    private enum DesignConstants {
        
    }
}

extension HeaderView: Observer {
    
    func update(subscriber: Subscriber) {
        let user: User = try! DataManager.shared.get(key: .User)
        self.profilePictureUrl = user.pictureUrl
    }

}
