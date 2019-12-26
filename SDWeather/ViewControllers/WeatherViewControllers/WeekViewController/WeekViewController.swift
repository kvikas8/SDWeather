//
//  WeekViewController.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import UIKit

// MARK: - Types

enum AlertType {
    case notAuthorizedToRequestLocation
    case failedToRequestLocation
    case noWeatherDataAvailable
}

class WeekViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: WeekViewModel? {
        didSet {
            // Hide Refresh Control
            
            if let viewModel = viewModel {
                // Setup View Model
                setupViewModel(with: viewModel)
            }
        }
    }
    
    // MARK: -
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.isHidden = true
            tableView.dataSource = self
            tableView.separatorInset = .zero
            tableView.estimatedRowHeight = 44.0
            tableView.showsVerticalScrollIndicator = false
            tableView.rowHeight = UITableView.automaticDimension
            
        }
    }
    
    // MARK: -
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            DispatchQueue.main.async {
                self.activityIndicatorView.startAnimating()
                self.activityIndicatorView.hidesWhenStopped = true
            }
        }
    }
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup View
        setupView()
        viewModel?.fetchWeather()
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        // Configure View
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Helper Methods
    
    private func setupViewModel(with viewModel: WeekViewModel) {
        
        // Configure View Model
        viewModel.didFetchWeatherData = { [weak self] (result) in
            // Hide Activity Indicator View
            DispatchQueue.main.async {
                self?.activityIndicatorView.stopAnimating() }
            
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
    
}

extension WeekViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfDays(in: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel?.title(for: section) ?? ""
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeekDayTableViewCell.reuseIdentifier, for: indexPath) as? WeekDayTableViewCell else {
            fatalError("Unable to Dequeue Week Day Table View Cell")
        }
        
        guard let viewModel = viewModel else {
            fatalError("No View Model Present")
        }
        
        // Configure Cell
        guard let wData = viewModel.viewModel(for: indexPath.row, section: indexPath.section) else {
            return cell
        }
        cell.configure(with: wData)
        
        return cell
    }
    
}
