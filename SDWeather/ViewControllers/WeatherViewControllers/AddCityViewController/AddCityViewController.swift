//
//  AddCityViewController.swift
//  SDWeather
//
//  Created by Vikas Kumar on 26/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import UIKit
protocol AddWeatherDelegate {
    func addWeatherDidSave(cities: [String])
}
class AddCityViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var delegate: AddWeatherDelegate?
    
    var viewModel: AddCityViewModel? {
        didSet {
            if let viewModel = viewModel {
                // Setup View Model
                setupViewModel(with: viewModel)
            }
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // MARK: - Actions
    
    @IBAction func saveCityButtonPressed() {
        
        if let cities = cityNameTextField.text {
            viewModel?.addCities(cities)
        }
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Methods
    
    private func setupViewModel(with viewModel: AddCityViewModel) {
        
        // Configure View Model
        viewModel.didEnteredCities = { [weak self] (isSuccess, errorMessage, cities) in
            if isSuccess {
                self?.delegate?.addWeatherDidSave(cities: cities)
                self?.dismiss(animated: true, completion: nil)
            } else {
                self?.errorLabel.text = errorMessage
            }
        }
    }
}

extension AddCityViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        errorLabel.text = ""
        return true
    }
}
