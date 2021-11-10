//
//  ProfileViewModel.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 08/11/21.
//

import UIKit

final class ProfileViewModel {
    
    /// Model status
    enum Status {
        case initial
        case loading
        case updating
        case error(String)
        case success([ProfileItem])
    }
    
    struct ProfileItem {
        let title: String
        let viewImageName: String
    }
    
    /// Properties
    private let service: ProfileService
    private let items: [ProfileItem] = [
        ProfileItem(title: "Mis clases", viewImageName: "MisClases"),
        ProfileItem(title: "Mi grupo", viewImageName: "MiGrupo"),
        ProfileItem(title: "Mis compras", viewImageName: "MisCompras"),
        ProfileItem(title: "Configuración", viewImageName: "Configuracion")
    ]
    private var user: User?
    private var time: Int = 0
    private var instructor: String = ""
    
    var updateStatusHandler: ((Status) -> Void)?
    
    var currentState: Status = .initial {
        didSet {
            updateStatusHandler?(currentState)
        }
    }
    
    /// Initializer
    init(service: ProfileService = .init()) {
        self.service = service
    }
    
    /// Public methods
    func getItems() {
        switch currentState {
        case .initial:
            currentState = .loading
        case .loading, .updating:
            return
        case .success:
            currentState = .updating
        default:
            break
        }
        self.user = DataManager.shared.get(key: .User)
        service.getMe(completionHandler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DataManager.shared.set(object: response.data!.profile, key: .User)
                self.user = response.data!.profile
                self.time =  response.data!.minutesDone
                self.instructor = response.data!.favorite
                var items = self.items
                if !self.user!.isLeader {
                    items.remove(at: 1)
                }
                self.currentState = .success(items)
            case .failure(let error):
                self.currentState = .error(error.localizedDescription)
            }
        })
    }
    
    func getTimeAndInstructor() -> [Any] {
        return [self.time, self.instructor]
    }
    
}
