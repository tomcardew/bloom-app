//
//  LoginViewController.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 03/11/21.
//

import UIKit
import AudioToolbox

class LoginViewController: BaseViewController {
    
    private let viewModel: LoginViewModel
    
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
        label.font = .poppins(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.text = "Accede para ver tus paquetes comprados, tus clases disponibles y reservar el horario que quieras."
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var emailTextField: Textfield = {
        let field = Textfield()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Correo electrónico"
        field.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        field.keyboardType = .emailAddress
        field.autocapitalize = .none
        return field
    }()
    
    private lazy var passTextField: Textfield = {
        let field = Textfield()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Contraseña"
        field.isPassword = true
        field.autocapitalize = .none
        field.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        return field
    }()
    
    private lazy var loginButton: BigButton = {
        let btn = BigButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.title = "Acceder"
        return btn
    }()
    
    private lazy var fbButton: BigButton = {
        let btn = BigButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.icon =  UIImage(named: "Fb")
        btn.bgColor = UIColor(red: 0.09, green: 0.47, blue: 0.95, alpha: 1.00)
        return btn
    }()
    
    private lazy var signupButton: BigButton = {
        let btn = BigButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.title = "Regístrate"
        btn.isDark = true
        return btn
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Close"), for: .normal)
        return button
    }()
    
    init(viewModel: LoginViewModel = .init()) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Life Cycle
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .clear
        self.view.setBlur(style: .extraLight)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addLayout()
        configureActions()
        bindViewModel()
    }
    
    // MARK: - Configurations
    private func configureView() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(descLabel)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passTextField)
        self.view.addSubview(loginButton)
        self.view.addSubview(fbButton)
        self.view.addSubview(signupButton)
        self.view.addSubview(closeButton)
    }
    
    private func addLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40)
        ])
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            descLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            descLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40)
        ])
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: self.descLabel.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            emailTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        NSLayoutConstraint.activate([
            passTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 20),
            passTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            passTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            passTextField.heightAnchor.constraint(equalToConstant: 52)
        ])
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: self.passTextField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            loginButton.heightAnchor.constraint(equalToConstant: 52)
        ])
        NSLayoutConstraint.activate([
            fbButton.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 20),
            fbButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            fbButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            fbButton.heightAnchor.constraint(equalToConstant: 52)
        ])
        NSLayoutConstraint.activate([
            signupButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            signupButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            signupButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            signupButton.heightAnchor.constraint(equalToConstant: 52)
        ])
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func bindViewModel() {
        viewModel.updateStatusHandler = self.updateState(_:)
    }
    
    // MARK: - Bindings
    private func updateState(_ state: LoginViewModel.Status) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.showLoader()
            case .loggedIn(let token):
                self.hideLoader()
                KeyManager.set(key: .Token, value: token)
                self.dismiss(animated: true, completion: nil)
            case .failed(let error):
                self.hideLoader()
                self.showAlert(title: "Error", description: error)
            default:
                print(self.viewModel.currentState)
            }
        }
    }
    
    private func configureActions() {
        loginButton.onClick(target: self, selector: #selector(didTapLogin))
        closeButton.addTarget(self, action: #selector(closeSelf), for: .touchUpInside)
    }
    
    @objc func didTapLogin() {
        let email = emailTextField.getValue()
        let password = passTextField.getValue()
        var allCorrect = true
        if email?.count == 0 {
            emailTextField.needsAttention()
            allCorrect = false
        }
        if password?.count == 0 {
            passTextField.needsAttention()
            allCorrect = false
        }
        if allCorrect {
            self.viewModel.login(email: emailTextField.getValue()!, password: passTextField.getValue()!)
        }
    }
    
    @objc func closeSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
