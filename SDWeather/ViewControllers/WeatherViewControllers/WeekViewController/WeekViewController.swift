//
//  WeekViewController.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import UIKit

class WeekViewController: UIViewController {
    
    // MARK: - Types
    
    private enum AlertType {
        case noWeatherDataAvailable
    }
    
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
        viewModel.didFetchWeatherData = { [weak self] (weatherData, error) in
            // Hide Activity Indicator View
            DispatchQueue.main.sync {
                self?.activityIndicatorView.stopAnimating() }
            
            if let _ = error {
                // Notify User
                self?.presentAlert(of: .noWeatherDataAvailable)
            } else if let _ = weatherData {
                // Initialize Week View Model
                DispatchQueue.main.sync {
                    // Update Table View
                    self?.tableView.reloadData()
                    self?.tableView.isHidden = false
                }
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
