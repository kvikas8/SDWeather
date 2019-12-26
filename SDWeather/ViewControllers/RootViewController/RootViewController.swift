//
//  RootViewController.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    
    private let addcityViewController: CurrentListViewController = {
        guard let currentViewController = UIStoryboard.main.instantiateViewController(withIdentifier: CurrentListViewController.storyboardIdentifier) as? CurrentListViewController else {
            fatalError("Unable to Instantiate Current View Controller")
        }
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
        let currentListViewModel = CurrentListViewModel(networkService: NetworkManager())
        // Configure Week View Controller
        addcityViewController.currentListViewModel = currentListViewModel
        self.navigationController?.pushViewController(addcityViewController, animated: true)
    }
    
    @IBAction func step2(_ sender: Any) {
        let weekViewModel = WeekViewModel(networkService: NetworkManager(), locationService: LocationManager())
        
        // Configure Week View Controller
        weekViewController.viewModel = weekViewModel
        self.navigationController?.pushViewController(weekViewController, animated: true)
    }
}

