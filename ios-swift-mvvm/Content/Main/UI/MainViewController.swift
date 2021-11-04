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

class MainViewController: BaseViewController {
    
    private let viewModel: MainViewModel
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppins(ofSize: 66, weight: .bold)
        label.text = "LA DECISIÓN ES TUYA"
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .center
        label.setDynamic()
        label.setShadow(color: UIColor.black.cgColor, size: CGSize(width: 0, height: 4), opacity: 0.1, radius: 10)
        return label
    }()
    
    private lazy var credits: Credits = {
        let label = Credits()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Life Cycle
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        addLayout()
        bindViewModel()
        viewModel.getImages()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.removeTimer()
    }
    
    // MARK: - Configurations
    private func configureView() {
        self.view.addSubview(backdropImage)
        self.view.addSubview(label)
        self.view.addSubview(credits)
    }
    
    private func addLayout() {
        NSLayoutConstraint.activate([
            backdropImage.topAnchor.constraint(equalTo: view.topAnchor, constant: getHeaderOffset()),
            backdropImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backdropImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdropImage.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 20)
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
        self.navigationController?.pushViewController(ContactViewController(), animated: true)
    }
    
}
