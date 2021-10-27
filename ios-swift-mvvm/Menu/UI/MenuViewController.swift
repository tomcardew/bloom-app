//
//  MenuViewController.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 27/10/21.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let viewModel: MenuViewModel

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Close"), for: .normal)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppins(ofSize: 32, weight: .bold)
        label.textColor = .bloom_pink
        label.text = "Menú"
        return label
    }()
    
    private lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppins(ofSize: 12, weight: .light)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .top
        stack.spacing = 20
        return stack
    }()
    
    // MARK: - Initializer
    init(viewModel: MenuViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Life Cycle
    override func loadView() {
        super.loadView()
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addLayout()
        bindViewModel()
        configureActions()
        
        self.viewModel.getOptions()
    }
    
    // MARK: - Configurations
    private func configureView() {
        self.view.addSubview(closeButton)
        self.view.addSubview(titleLabel)
        self.view.addSubview(versionLabel)
        self.view.addSubview(stackView)
    }
    
    private func addLayout() {
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40)
        ])
        NSLayoutConstraint.activate([
            versionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            versionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func configureActions() {
        self.closeButton.addTarget(self, action: #selector(closeSelf), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel.updateStatusHandler = self.updateState(_:)
    }
    
    private func updateState(_ state: MenuViewModel.Status) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .loadedVersion(let version):
                self.versionLabel.text = version
            case .loadedOptions(let options):
                self.loadOptions(with: options)
                self.viewModel.getVersion()
            default:
                print("Default")
            }
        }
    }
    
    private func loadOptions(with options: [String:UIViewController?]) {
        for option in options {
            let label = UILabel()
            label.font = .poppins(ofSize: 32, weight: .medium)
            label.textColor = .black
            label.text = option.key
            self.stackView.addArrangedSubview(label)
        }
    }
    
    @objc func closeSelf() {
        self.dismiss(animated: true, completion: nil)
    }

}
