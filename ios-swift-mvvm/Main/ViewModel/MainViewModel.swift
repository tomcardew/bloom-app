//
//  MainViewModel.swift
//  ios-swift-mvvm
//
//  Created by Andrés Villagomez Ríos on 25/10/21.
//

import Foundation

final class MainViewModel {
    
    /// Model status
    enum Status {
        case initial
        case loading
        case loaded
        case failed(Error)
    }
    
    /// View Model Configuration
    struct MainDisplayModel {
        let date: Date
        let start: String
        let instructorName: String
        let roomName: String
    }
    
    /// Properties
    private var currentIndex: Int = 0
    private let service: MainService
    private var images: [ImagesModel] = []
    private var timer: Timer? = nil
    
    var updateStatusHandler: ((Status) -> Void)?
    var updateCurrentImage: ((URL) -> Void)?
    
    var currentState: Status = .initial {
        didSet {
            updateStatusHandler?(currentState)
        }
    }
    
    var currentImageUrl: URL = URL(string: "https://google.com")! {
        didSet {
            updateCurrentImage?(currentImageUrl)
        }
    }
    
    /// Initializer
    init(service: MainService = .init()) {
        self.service = service
    }
    
    /// Public methods
    func getImages() {
        switch currentState {
        case .loading:
            return
        default:
            break
        }
        
        currentState = .loading
        
        service.getImages(completionHandler: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let items):
                self.images = items.data!
                self.currentState = .loaded
                self.getNextImage()
            case .failure(let error):
                self.currentState = .failed(error)
            }
        })
    }
    
    func startTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.getNextImage), userInfo: nil, repeats: true)
    }
    
    func removeTimer() {
        self.timer?.invalidate()
    }
    
    @objc func getNextImage() {
        if images.count > 0 {
            var url = images[currentIndex].url
            if !url.contains("https://") {
                url = url.replacingOccurrences(of: "http://", with: "https://")
            }
            if self.currentIndex + 1 >= images.count {
                self.currentIndex = 0
            } else {
                self.currentIndex += 1
            }
            print(url)
            self.currentImageUrl = URL(string: url)!
        }
    }
    
}
