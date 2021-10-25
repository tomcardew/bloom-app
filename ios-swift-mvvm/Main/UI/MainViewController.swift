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
        let view = UIViewController()
        view.view.backgroundColor = .red
        return view
    }()
    
    private var sideMenu: SideMenuNavigationController? = nil
    
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
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    //    private lazy var bgImage: UIImageView = {
    //        let imageView = UIImageView()
    //        imageView.translatesAutoresizingMaskIntoConstraints = false
    //        imageView.image = UIImage(named: "MainBgScreen")
    //        imageView.contentMode = .scaleAspectFill
    //        return imageView
    //    }()
    
    let motionManager = CMMotionManager()
    
    private lazy var featuredButton: BigButton = {
        let btn = BigButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.title = "Ver horarios"
        btn.delegate = self
        return btn
    }()
    
    // MARK: - Initializer
    init(viewModel: MainViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        sideMenu = SideMenuNavigationController(rootViewController: sideSide)
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
        self.view.addSubview(featuredButton)
    }
    
    private func addLayout() {
        NSLayoutConstraint.activate([
            backdropImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backdropImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            backdropImage.widthAnchor.constraint(equalToConstant: view.frame.width - 60 ),
            backdropImage.heightAnchor.constraint(equalToConstant: view.frame.width - 60 )
        ])
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            header.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            header.heightAnchor.constraint(equalToConstant: 70),
            header.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            featuredButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            featuredButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            featuredButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            featuredButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func bindViewModel() {
        viewModel.updateStatusHandler = self.updateState(_:)
        viewModel.updateCurrentImage = self.updateCurrentImage(_:)
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
