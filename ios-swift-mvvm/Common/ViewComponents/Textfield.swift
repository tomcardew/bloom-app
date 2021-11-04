//
//  Textfield.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 04/11/21.
//

import UIKit

class Textfield: UIView {
    
    var title: String = "" {
        didSet {
            self.textfield.text = title
        }
    }
    
    var placeholder: String = "" {
        didSet {
            self.placeholderView.text = placeholder
        }
    }
    
    var isPassword: Bool = false {
        didSet {
            setupPassword(active: isPassword)
        }
    }
    
    var keyboardType: UIKeyboardType = .default {
        didSet {
            self.textfield.keyboardType = keyboardType
        }
    }
    
    var autocapitalize: UITextAutocapitalizationType = .sentences {
        didSet {
            self.textfield.autocapitalizationType = autocapitalize
        }
    }
    
    //MARK: - Properties
    private lazy var textfield: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .poppins(ofSize: 16, weight: .regular)
        field.textColor = .black
        field.autocorrectionType = .no
        return field
    }()
    
    private lazy var placeholderView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppins(ofSize: 16, weight: .regular)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return label
    }()
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isHidden = true
        image.image = UIImage(named: "Visible")
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
    private func setupViews() {
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.addSubview(placeholderView)
        self.addSubview(textfield)
        self.addSubview(iconImage)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            placeholderView.topAnchor.constraint(equalTo: self.topAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            placeholderView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            placeholderView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            textfield.topAnchor.constraint(equalTo: self.topAnchor),
            textfield.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            textfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            iconImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            iconImage.heightAnchor.constraint(equalToConstant: 24),
            iconImage.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupActions() {
        self.textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(togglePassword))
        gesture.numberOfTapsRequired = 1
        self.iconImage.addGestureRecognizer(gesture)
        self.iconImage.isUserInteractionEnabled = true
    }
    
    @objc func textFieldDidChange(_ textfield: UITextField) {
        if (textfield.text!.count > 0) {
            self.placeholderView.isHidden = true
        } else {
            self.placeholderView.isHidden = false
        }
    }
    
    @objc func togglePassword() {
        if self.textfield.isSecureTextEntry {
            self.textfield.isSecureTextEntry = false
            self.iconImage.image = UIImage(named: "Invisible")
        } else {
            self.textfield.isSecureTextEntry = true
            self.iconImage.image = UIImage(named: "Visible")
        }
    }
    
    private func setupPassword(active: Bool) {
        if (active) {
            self.textfield.isSecureTextEntry = true
            self.iconImage.isHidden = false
            textfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = false
            NSLayoutConstraint.activate([
                textfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -64)
            ])
            textfield.layoutIfNeeded()
        } else {
            self.textfield.isSecureTextEntry = false
            self.iconImage.isHidden = true
        }
    }
    
    public func getValue() -> String? {
        return self.textfield.text
    }
    
}
