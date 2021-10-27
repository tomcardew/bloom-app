//
//  MainViewController.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 25/10/21.
//

import UIKit
import SideMenu
import Nuke
import CoreMotion

class MainViewController: UIViewController {
    
    private let viewModel: MainViewModel
    
    private lazy var sideSide: UIViewController = {
        let view = MenuViewController()
        return view
    }()
    
    private var sideMenu: SideMenuNavigationController? = nil
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppins(ofSize: 66, weight: .bold)
        label.text = "LA DECISIÓN ES TUYA"
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .center
        label.setShadow(color: UIColor.black.cgColor, size: CGSize(width: 0, height: 4), opacity: 0.1, radius: 10)
        return label
    }()
    
    private lazy var credits: Credits = {
        let label = Credits()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var header: HeaderView = {
        let header = HeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.delegate = self
        return header
    }()
    
    private lazy var backdropImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "DefaultBackdrop")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.opacity = 1
        return imageView
    }()
    
    // MARK: - Initializer
    init(viewModel: MainViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        sideMenu = SideMenuNavigationController(rootViewController: sideSide)
        sideMenu!.leftSide = true
        sideMenu!.presentationStyle = .menuSlideIn
        sideMenu!.presentingViewControllerUseSnapshot = true
        sideMenu!.menuWidth = UIScreen.main.bounds.width
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Life Cycle
    override func loadView() {
        super.loadView()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addLayout()
        bindViewModel()
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        
        viewModel.getImages()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.removeTimer()
    }
    
    // MARK: - Configurations
    private func configureView() {
        self.view.addSubview(backdropImage)
        self.view.addSubview(header)
        self.view.addSubview(label)
        self.view.addSubview(credits)
    }
    
    private func addLayout() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.heightAnchor.constraint(equalToConstant: 120),
            header.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            backdropImage.topAnchor.constraint(equalTo: header.bottomAnchor),
            backdropImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backdropImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdropImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 100)
        ])
        NSLayoutConstraint.activate([
            credits.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            credits.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            credits.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func bindViewModel() {
        viewModel.updateStatusHandler = self.updateState(_:)
        viewModel.updateCurrentImage = self.updateCurrentImage(_:)
        credits.handlePressed = {
            self.openCredits()
        }
    }
    
    // MARK: - Bindings
    private func updateState(_ state: MainViewModel.Status) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .loaded:
                self.viewModel.startTimer()
            default:
                print(self.viewModel.currentState)
            }
        }
    }
    
    private func updateCurrentImage(_ image: URL) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            var options = ImageLoadingOptions()
            options.transition = .fadeIn(duration: 1.0)
            options.alwaysTransition = true
            Nuke.loadImage(with: image, options: options, into: self.backdropImage)
        }
    }
    
    private func openCredits() {
        print("CRedits!")
    }
    
}

extension MainViewController {
    
    func updateBackdropImage(_ image: UIImage) {
        
    }
    
}

extension MainViewController: HeaderDelegate {
    
    func didPressMenu() {
        present(sideMenu!, animated: true, completion: nil)
    }
    
}

extension MainViewController: BigButtonDelegate {
    
    func didPressButton() {
        print("Pressed button")
    }
    
}
