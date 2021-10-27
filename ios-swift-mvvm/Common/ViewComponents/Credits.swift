//
//  Credits.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 27/10/21.
//

import UIKit

class Credits: UIView {
    
    // MARK: Properties
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppins(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.setShadow(color: UIColor.black.cgColor, size: CGSize(width: 0, height: 4), opacity: 0.25, radius: 4)
        label.textAlignment = .center
        label.numberOfLines = 2
        let year = Calendar.current.component(.year, from: Date())
        label.text = "Bloom Cycling Studio - Derechos Reservados \(year)\nTérminos y condiciones del servicio"
        return label
    }()
    
    var handlePressed: (() -> ())?

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
    
    private func setupViews() {
        self.addSubview(label)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func setupActions() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pressed))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
    }
    
    @objc func pressed() {
        self.handlePressed?()
    }

}
