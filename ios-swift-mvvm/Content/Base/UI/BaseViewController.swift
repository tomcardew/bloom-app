//
//  BaseViewController.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 28/10/21.
//

import UIKit
import SideMenu

class BaseViewController: UIViewController {
    
    var headerOffset: CGFloat {
        get {
            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                return 80
            case .phone:
                return 100
            default:
                return 100
            }
        }
    }
    
    private lazy var menuViewController: MenuViewController = {
        let view = MenuViewController()
        return view
    }()
    
    internal var sideMenuNavigationController: SideMenuNavigationController? = nil
    
    private lazy var header: HeaderView = {
        let header = HeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = .white
        return header
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func commonInit() {
        menuViewController.delegate = self
    }
    
    // MARK: - View Controller Life Cycle
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if SideMenuManager.default.leftMenuNavigationController == nil {
            configureHeader()
            sideMenuNavigationController = SideMenuNavigationController(rootViewController: menuViewController)
            sideMenuNavigationController!.leftSide = true
            sideMenuNavigationController!.presentationStyle = .menuSlideIn
            sideMenuNavigationController!.presentingViewControllerUseSnapshot = true
            sideMenuNavigationController!.menuWidth = UIScreen.main.bounds.width
            SideMenuManager.default.leftMenuNavigationController = self.sideMenuNavigationController
        }
        if let token: String = KeyManager.get(key: .Token) {
            let user: User = try! DataManager.shared.get(key: .User)
            print("viedidload base view run")
            self.header.configure(with: user)
        }
        self.navigationItem.setHidesBackButton(true, animated: false)
        addLayout()
    }
    
    // MARK: - Configurations
    private func configureHeader() {
        header.delegate = self
        let bounds = self.navigationController!.navigationBar.bounds
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: headerOffset)
        self.navigationController?.navigationBar.addSubview(header)
    }
    
    private func addLayout() {
        NSLayoutConstraint.activate([
            header.heightAnchor.constraint(equalToConstant: headerOffset),
            header.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }

}

extension BaseViewController {
    
    func getHeaderOffset() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight + self.headerOffset
    }
    
}

extension BaseViewController: MenuDelegate {
    
    func didPressedMenu(vc: UIViewController) {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension BaseViewController: HeaderDelegate {
    
    func didPressMenu() {
        self.navigationController?.present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
    
    func didPressUser() {
        self.navigationController?.popViewController(animated: true)
        let token: String? = KeyManager.get(key: .Token)
        if token != nil && !token!.isEmpty {
            self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        } else {
            let view = LoginViewController()
            view.modalPresentationStyle = .overFullScreen
            view.modalTransitionStyle = .crossDissolve
            self.present(view, animated: true, completion: nil)
        }
    }
    
    func didPressHome() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
