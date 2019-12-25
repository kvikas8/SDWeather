//
//  RootViewController.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    
    // MARK: - Properties

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
        
        // Fetch Weather Data
        fetchWeatherData()
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
    
    private func fetchWeatherData() {
        // Create Base URL
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=London&APPID=7d2dd8c9c5578b741c7735ad3f0d39ea&units=imperial") else {
            return
        }
        
        // Create Data Task
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Request Did Fail (\(error)")
            } else if let response = response {
                print(response)
            }
        }.resume()
    }
    
}

extension RootViewController {

    fileprivate enum Layout {
        enum CurrentView {
            static let height: CGFloat = 200.0
        }
    }

}
