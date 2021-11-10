//
//  ProfileViewController.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 28/10/21.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    private let viewModel: ProfileViewModel
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppins(ofSize: 32, weight: .bold)
        label.textColor = .bloom_pink
        label.text = "Perfil"
        label.setDynamic()
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alwaysBounceVertical = true
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppins(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.text = "Este mes has pedaleado durante 4 horas y tu instructor favorito es Tony. ¡Sigue así!"
        label.numberOfLines = 0
        label.setDynamic()
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
    
    private lazy var logoutButton: BigButton = {
        let btn = BigButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.title = "Cerrar sesión"
        btn.bgColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        btn.textColor = .black
        return btn
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Close"), for: .normal)
        return button
    }()
    
    init(viewModel: ProfileViewModel = .init()) {
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
        self.view.setBlur(style: .systemChromeMaterialLight)
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addLayout()
        bindViewModel()
        configureActions()
        
        viewModel.getItems()
    }
    
    // MARK: - Configurations
    private func configureView() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(closeButton)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(summaryLabel)
        self.contentView.addSubview(stackView)
    }
    
    private func addLayout() {
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.summaryLabel.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])
    }
    
    private func bindViewModel() {
        viewModel.updateStatusHandler = self.updateState(_:)
    }
    
    // MARK: - Bindings
    private func updateState(_ state: ProfileViewModel.Status) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.showLoader()
            case .updating:
                self.hideLoader()
            case .success(let items):
                self.hideLoader()
                self.setupMenuItems(items: items)
                let times = self.viewModel.getTimeAndInstructor()
                self.setupSummaryLabel(time: times[0] as! Int, instructor: times[1] as! String)
                if times[0] as! Int == 0 {
                    self.summaryLabel.text = "¡Aún no has pedaleado! ¿Qué te detiene?"
                }
            case .error(let error):
                self.hideLoader()
                self.showAlert(title: "Error", description: error, onClose: {
                    self.logout()
                })
            default:
                print(self.viewModel.currentState)
            }
        }
    }
    
    private func configureActions() {
        logoutButton.onClick(target: self, selector: #selector(logout))
        closeButton.onClick(target: self, selector: #selector(closeSelf))
    }
    
    private func setupMenuItems(items: [ProfileViewModel.ProfileItem]) {
        for item in items {
            let menu = ProfileMenuItem()
            menu.translatesAutoresizingMaskIntoConstraints = false
            menu.clipsToBounds = true
            menu.layer.cornerRadius = 10
            let image = UIImage(named: item.viewImageName)!
            menu.configure(text: item.title, image: image)
            self.stackView.addArrangedSubview(menu)
            NSLayoutConstraint.activate([
                menu.heightAnchor.constraint(equalToConstant: 120),
                menu.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                menu.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            ])
        }
        self.stackView.addArrangedSubview(logoutButton)
        NSLayoutConstraint.activate([
            logoutButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: getScrollSize(itemCount: items.count))
        ])
    }
    
    private func setupSummaryLabel(time: Int = 240, instructor: String = "") {
        let hours = time / 60
        let timeLength = "\(hours)".count
        let instructorLength = instructor.count
        let str = "Este mes has pedaleado durante \(hours) horas y tu instructor más visitado es \(instructor). ¡Sigue así!"
        let mutableString = NSMutableAttributedString(string: str, attributes: [.font: UIFont.poppins(ofSize: 18, weight: .medium)])
        mutableString.addAttributes([.font: UIFont.poppins(ofSize: 18, weight: .bold)], range: NSRange(location: 31, length: timeLength + 6))
        mutableString.addAttributes([.font: UIFont.poppins(ofSize: 18, weight: .bold)], range: NSRange(location: 31 + timeLength + 6 + 33, length: instructorLength))
        self.summaryLabel.attributedText = mutableString
    }
    
    private func getScrollSize(itemCount: Int) -> CGFloat {
        let itemSize = CGFloat((120 * itemCount) + (20 * (itemCount - 1)))
        let summarySize = CGFloat(82 + 80 + 60 + 40)
        return CGFloat(itemSize + summarySize)
    }
    
    @objc func logout() {
        DataManager.shared.deleteAll()
        self.dismiss(animated: true)
    }
    
    @objc func closeSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

