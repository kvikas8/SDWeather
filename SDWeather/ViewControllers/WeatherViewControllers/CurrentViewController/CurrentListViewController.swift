//
//  CurrentViewController.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import UIKit

class CurrentListViewController: UITableViewController, AddWeatherDelegate {
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View
        setupView()
    }
    
    // MARK: - Properties
    var cityName: String?
    
    var currentListViewModel: CurrentListViewModel? {
        didSet {
            if let viewModel = currentListViewModel {
                // Setup View Model
                setupViewModel(with: viewModel)
            }
        }
    }
    
    // MARK: - Methods
    
    private func setupView() {
        // Configure View
        view.backgroundColor = .white
    }
    
    
    private func setupViewModel(with viewModel: CurrentListViewModel) {
        
        // Configure View Model
        viewModel.didFetchWeatherData = { [weak self] (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    // Update Table View
                    self?.tableView.reloadData()
                    self?.tableView.isHidden = false
                }
            case .failure(let error):
                let alertType: AlertType
                switch error {
                case .noWeatherDataAvailable:
                    alertType = .dataNotAvailableForAllCities
                default:
                    alertType = .dataNotAvailableForAllCities
                }
                
                // Notify User
                self?.presentAlert(of: alertType)
            }
        }
        
        
    }
    
   func addWeatherDidSave(cities: [String]) {
        self.currentListViewModel?.addWeatherViewModel(for: cities)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "AddCityViewController" {
            
            prepareSegueForAddWeatherCityViewController(segue: segue)
            
        }
        
    }
    
    private func prepareSegueForAddWeatherCityViewController(segue: UIStoryboardSegue) {
        
        guard let nav = segue.destination as? UINavigationController else {
            fatalError("NavigationController not found")
        }
        
        guard let addWeatherCityVC = nav.viewControllers.first as? AddCityViewController else {
            fatalError("AddCityViewController not found")
        }
        addWeatherCityVC.viewModel = AddCityViewModel()
        addWeatherCityVC.delegate = self
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentListViewModel?.numberOfRows(section) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherCell.reuseIdentifier, for: indexPath) as? CurrentWeatherCell else {
            fatalError("Unable to Dequeue Week Day Table View Cell")
        }
        
        // Configure Cell
        guard let wData = currentListViewModel?.modelAt(indexPath.row) else { return cell }
        cell.configure(with: wData)
        
        return cell
    }
    
}
