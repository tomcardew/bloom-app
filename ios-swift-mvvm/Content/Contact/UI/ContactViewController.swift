//
//  ContactViewController.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 28/10/21.
//

import UIKit
import MapKit
import CoreLocation

class ContactViewController: BaseViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppins(ofSize: 32, weight: .bold)
        label.textColor = .bloom_pink
        label.text = "Contacto"
        label.setDynamic()
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .poppins(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = """
        Cortijo Santa María de los Alamares,
        Camino a los Azulejos #1 Rancho Los Azulejos, Valle Escondido, Ciudad Lopez Mateos, Estado de México CP. 52970
        
        Tel. 55 8051 0715
        """
        return label
    }()
    
    private lazy var map: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.layer.cornerRadius = 10
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 19.578524, longitude: -99.282371), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 19.578524, longitude: -99.282371)
        map.setRegion(region, animated: true)
        map.addAnnotation(annotation)
        return map
    }()
    
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
        self.view.addSubview(addressLabel)
        self.view.addSubview(map)
    }
    
    private func addLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.getHeaderOffset() + 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40)
        ])
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
            addressLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            addressLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40)
        ])
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: self.addressLabel.bottomAnchor, constant: 20),
            map.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40),
            map.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40),
            map.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40)
        ])
    }
    
    private func configureActions() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openMap))
        self.map.addGestureRecognizer(gesture)
    }
    
    @objc func openMap() {
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 19.578524, longitude: -99.282371))
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Bloom Cycling Studio"
        mapItem.openInMaps(launchOptions: nil)
    }
    
}
