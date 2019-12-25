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
    
}

extension RootViewController {

    fileprivate enum Layout {
        enum CurrentView {
            static let height: CGFloat = 200.0
        }
    }

}
