//
//  RootViewController.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    
    // MARK: - Types
    
    private enum AlertType {
        case noWeatherDataAvailable
    }
    
    // MARK: - Properties
    
    var viewModel: RootViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            // Setup View Model
            setupViewModel(with: viewModel)
        }
    }
    
    private let currentViewController: CurrentViewController = {
        guard let currentViewController = UIStoryboard.main.instantiateViewController(withIdentifier: CurrentViewController.storyboardIdentifier) as? CurrentViewController else {
            fatalError("Unable to Instantiate Current View Controller")
        }
        
        // Configure Current View Controller
        currentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return currentViewController
    }()
    
    private let weekViewController: WeekViewController = {
        guard let weekViewController = UIStoryboard.main.instantiateViewController(withIdentifier: WeekViewController.storyboardIdentifier) as? WeekViewController else {
            fatalError("Unable to Instantiate Week View Controller")
        }
        
        // Configure Week View Controller
        weekViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        return weekViewController
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Child View Controllers
        setupChildViewControllers()
        
    }
    
    // MARK: - Helper Methods
    
    private func setupChildViewControllers() {
        // Add Child View Controllers
        addChild(currentViewController)
        addChild(weekViewController)
        
        // Add Child View as Subview
        view.addSubview(currentViewController.view)
        view.addSubview(weekViewController.view)
        
        // Configure Day View
        currentViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        currentViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        currentViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        currentViewController.view.heightAnchor.constraint(equalToConstant: Layout.CurrentView.height).isActive = true
        
        // Configure Week View
        weekViewController.view.topAnchor.constraint(equalTo: currentViewController.view.bottomAnchor).isActive = true
        weekViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        weekViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        weekViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Notify Child View Controller
        currentViewController.didMove(toParent: self)
        weekViewController.didMove(toParent: self)
    }
    
    private func setupViewModel(with viewModel: RootViewModel) {
        // Configure View Model
        viewModel.didFetchWeatherData = { [weak self] (data, error) in
            if let _ = error {
                // Notify User
                self?.presentAlert(of: .noWeatherDataAvailable)
            } else if let data = data as? WeatherResponse {
                print(data.windSpeed)
            } else {
                // Notify User
                self?.presentAlert(of: .noWeatherDataAvailable)
            }
        }
    }
    
    private func presentAlert(of alertType: AlertType) {
        // Helpers
        let title: String
        let message: String
        
        switch alertType {
        case .noWeatherDataAvailable:
            title = "Unable to Fetch Weather Data"
            message = "The application is unable to fetch weather data. Please make sure your device is connected over Wi-Fi or cellular."
        }
        DispatchQueue.main.sync {
        // Initialize Alert Controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Add Cancel Action
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // Present Alert Controller
        self.present(alertController, animated: true)
            
        }
    }
    
}

extension RootViewController {
    
    fileprivate enum Layout {
        enum CurrentView {
            static let height: CGFloat = 200.0
        }
    }
    
}
