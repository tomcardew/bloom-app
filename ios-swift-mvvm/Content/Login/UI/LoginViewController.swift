//
//  LoginViewController.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 03/11/21.
//

import UIKit

class LoginViewController: BaseViewController {
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "Login")
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppins(ofSize: 32, weight: .bold)
        label.textColor = .bloom_pink
        label.text = "Iniciar sesión"
        label.setDynamic()
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppins(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.text = "Accede para ver tus paquetes comprados, tus clases disponibles y reservar el horario que quieras."
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var loginButton: BigButton = {
        let btn = BigButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.title = "Acceder"
        return btn
    }()
    
    private lazy var signupButton: BigButton = {
        let btn = BigButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.title = "Regístrate"
        btn.isDark = true
        return btn
    }()
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Life Cycle
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addLayout()
        configureActions()
    }
    
    // MARK: - Configurations
    private func configureView() {
        self.view.addSubview(imageView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(descLabel)
        self.view.addSubview(loginButton)
        self.view.addSubview(signupButton)
    }
    
    private func addLayout() {
        NSLayoutConstraint.activate([
            signupButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40),
            signupButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            signupButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            signupButton.heightAnchor.constraint(equalToConstant: 52)
        ])
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: self.signupButton.topAnchor, constant: -20),
            loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            loginButton.heightAnchor.constraint(equalToConstant: 52)
        ])
        NSLayoutConstraint.activate([
            descLabel.bottomAnchor.constraint(equalTo: self.loginButton.topAnchor, constant: -40),
            descLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            descLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            descLabel.heightAnchor.constraint(equalToConstant: 81)
        ])
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: self.descLabel.topAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            titleLabel.heightAnchor.constraint(equalToConstant: 48)
        ])
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -20),
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
    }
    
    private func configureActions() {
        
    }

}
