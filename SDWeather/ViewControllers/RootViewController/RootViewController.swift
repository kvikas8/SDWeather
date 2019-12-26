//
//  RootViewController.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    
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
        
        return weekViewController
    }()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func step1(_ sender: Any) {
    }
    
    @IBAction func step2(_ sender: Any) {
        let weekViewModel = WeekViewModel()
        
        // Configure Week View Controller
        weekViewController.viewModel = weekViewModel
        self.navigationController?.pushViewController(weekViewController, animated: true)
    }
}

