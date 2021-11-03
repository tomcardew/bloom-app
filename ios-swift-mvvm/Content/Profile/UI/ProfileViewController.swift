//
//  ProfileViewController.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 28/10/21.
//

import UIKit

struct ProfileItem {
    let title: String
    let view: UIImage
}

class ProfileViewController: BaseViewController {
    
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
        label.text = "Este mes has pedaleado durante 4 horas y quemado alrededor de 5000 kcal. ¡Sigue así!"
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
    
//    private lazy var menu: ProfileMenuItem = {
//        let menu = ProfileMenuItem()
//        menu.translatesAutoresizingMaskIntoConstraints = false
//        menu.clipsToBounds = true
//        menu.layer.cornerRadius = 10
//        return menu
//    }()
    
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
        self.view.addSubview(titleLabel)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(summaryLabel)
        self.contentView.addSubview(stackView)
    }
    
    private func addLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.getHeaderOffset() + 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40)
        ])
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.summaryLabel.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])
        setupSummaryLabel()
        setupMenuItems()
    }
    
    private func configureActions() {
        
    }
    
    private func setupMenuItems() {
        let items: [ProfileItem] = [
            ProfileItem(title: "Mis clases", view: UIImage(named: "MisClases")!),
            ProfileItem(title: "Mi grupo", view: UIImage(named: "MiGrupo")!),
            ProfileItem(title: "Mis compras", view: UIImage(named: "MisCompras")!),
            ProfileItem(title: "Configuración", view: UIImage(named: "Configuracion")!)
        ]
        for item in items {
            let menu = ProfileMenuItem()
            menu.translatesAutoresizingMaskIntoConstraints = false
            menu.clipsToBounds = true
            menu.layer.cornerRadius = 10
            menu.configure(text: item.title, image: item.view)
            self.stackView.addArrangedSubview(menu)
            NSLayoutConstraint.activate([
                menu.heightAnchor.constraint(equalToConstant: 120),
                menu.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                menu.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            ])
        }
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: getScrollSize(itemCount: items.count))
        ])
    }
    
    private func setupSummaryLabel(time: Int = 4, calories: Int = 0) {
        let timeLength = "\(time)".count
        let caloriesLength = "\(calories)".count
        let str = "Este mes has pedaleado durante \(time) horas y quemado alrededor de \(calories) kcal. ¡Sigue así!"
        let mutableString = NSMutableAttributedString(string: str, attributes: [.font: UIFont.poppins(ofSize: 18, weight: .medium)])
        mutableString.addAttributes([.font: UIFont.poppins(ofSize: 18, weight: .bold)], range: NSRange(location: 31, length: timeLength + 6))
        mutableString.addAttributes([.font: UIFont.poppins(ofSize: 18, weight: .bold)], range: NSRange(location: 31 + timeLength + 6 + 24, length: caloriesLength + 6))
        self.summaryLabel.attributedText = mutableString
    }
    
    private func getScrollSize(itemCount: Int) -> CGFloat {
        // CGFloat((120 * items.count) + (20 * (items.count - 1)) + summaryLabel.bounds.size.height + 40)
        let itemSize = CGFloat((120 * itemCount) + (20 * (itemCount - 1)))
        let summarySize = CGFloat(82 + 80)
        print(CGFloat(itemSize + summarySize))
        return CGFloat(itemSize + summarySize)
    }
    
}
