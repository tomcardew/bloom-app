//
//  MenuViewModel.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 27/10/21.
//

import Foundation
import UIKit

final class MenuViewModel {
    
    /// Model status
    enum Status {
        case initial
        case loading
        case loadedVersion(String)
        case loadedOptions([String:UIViewController?])
        case failed(Error)
    }
    
    /// View Model Configuration
    struct VersionDisplayModel {
        let version: Int
        let date: String
        
        var versionString: String {
            get {
                return "Build \(version)\n\( date.prefix(10) )"
            }
        }
        
    }
    
    /// Properties
    private let service: MenuService
    private var version: VersionDisplayModel?
    private let options: [String: UIViewController?]
    
    var updateStatusHandler: ((Status) -> Void)?
    var currentState: Status = .initial {
        didSet {
            updateStatusHandler?(currentState)
        }
    }
    
    /// Initializer
    init(service: MenuService = .init()) {
        self.service = service
        self.options = ["Horarios": UIViewController(), "Paquetes": UIViewController(), "Instructores": UIViewController(), "Contacto": UIViewController()]
    }
    
    /// Public methods
    func getVersion() {
        switch currentState {
        case .loading:
            return
        default:
            break
        }
        
        currentState = .loading
        
        service.getVersion(completionHandler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let item):
                self.version = VersionDisplayModel(version: item.version!.version, date: item.version!.createdAt)
                self.currentState = .loadedVersion(self.version!.versionString)
            case .failure(let error):
                self.currentState = .failed(error)
            }
        })
    }
    
    func getOptions() {
        self.currentState = .loadedOptions(self.options)
    }
    
}
