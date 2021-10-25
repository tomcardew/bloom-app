//
//  FeaturedViewModel.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 20/10/21.
//

import Foundation

final class SchedulesNoAuthViewModel {
    
    /// Model status
    enum Status {
        case initial
        case loading
        case loaded
        case failed(Error)
    }
    
    /// View Model Configuration
    struct SchedulesDisplayModel {
        let date: Date
        let start: String
        let instructorName: String
        let roomName: String
    }
    
    /// Properties
    private let service: SchedulesNoAuthService
    private var items: [[ScheduleModel]] = []
    var updateStatusHandler: ((Status) -> Void)?
    
    var currentState: Status = .initial {
        didSet {
            updateStatusHandler?(currentState)
        }
    }
    
    /// Initializer
    init(service: SchedulesNoAuthService = .init()) {
        self.service = service
    }
    
    /// Public methods
    func getSchedules() {
        switch currentState {
        case .loading:
            return
        default:
            break
        }
        
        currentState = .loading
        
        service.getSchedules(completionHandler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                self.items = items.schedules!
                self.currentState = .loaded
            case .failure(let error):
                self.currentState = .failed(error)
            }
        })
    }
    
    func getSchedulesCountByIndex(index: Int) -> Int {
        return self.items[index].count
    }
    
}
