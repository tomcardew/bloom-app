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
        case loadedOptions
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
    
    struct OptionModel {
        let name: String
        let vc: UIViewController?
    }
    
    /// Properties
    private let service: MenuService
    private var version: VersionDisplayModel?
    private var options: [OptionModel]
    
    var updateStatusHandler: ((Status) -> Void)?
    var currentState: Status = .initial {
        didSet {
            updateStatusHandler?(currentState)
        }
    }
    
    /// Initializer
    init(service: MenuService = .init()) {
        self.service = service
        self.options = []
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
        switch currentState {
        case .loading:
            return
        default:
            break
        }
        
        self.options = [OptionModel(name: "Horarios", vc: nil), OptionModel(name: "Paquetes", vc: nil), OptionModel(name: "Instructores", vc: nil) , OptionModel(name: "Contacto", vc: ContactViewController())]
        currentState = .loadedOptions
    }
    
    func getOptionLabel(at index: Int) -> String {
        return self.options[index].name
    }
    
    func getViewController(at index: Int) -> UIViewController? {
        return self.options[index].vc
    }
    
    func getOptionsCount() -> Int {
        return self.options.count
    }
    
}
