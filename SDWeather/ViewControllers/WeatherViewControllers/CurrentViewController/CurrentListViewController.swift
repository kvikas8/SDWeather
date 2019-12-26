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
            // Hide Activity Indicator View
            //            DispatchQueue.main.sync {
            //                self?.activityIndicatorView.stopAnimating() }
            
            switch result {
            case .success(_):
                DispatchQueue.main.sync {
                    // Update Table View
                    self?.tableView.reloadData()
                    self?.tableView.isHidden = false
                }
            case .failure(let error):
                let alertType: AlertType
                
                switch error {
                case .notAuthorizedToRequestLocation:
                    alertType = .notAuthorizedToRequestLocation
                case .failedToRequestLocation:
                    alertType = .failedToRequestLocation
                case .noWeatherDataAvailable:
                    alertType = .noWeatherDataAvailable
                }
                
                // Notify User
                self?.presentAlert(of: alertType)
            }
        }
        
        
    }
    
    func addWeatherDidSave(newCityName: String) {
        self.currentListViewModel?.addWeatherViewModel(for: newCityName)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddCityViewController" {
            
            prepareSegueForAddWeatherCityViewController(segue: segue)
            
        }
        
    }
    
    private func prepareSegueForAddWeatherCityViewController(segue: UIStoryboardSegue) {
        
        guard let addWeatherCityVC = segue.destination as? AddCityViewController else {
            fatalError("AddCityViewController not found")
        }
        
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
