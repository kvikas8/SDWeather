//
//  AddCityViewController.swift
//  SDWeather
//
//  Created by Vikas Kumar on 26/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import UIKit
protocol AddWeatherDelegate {
    func addWeatherDidSave(newCityName: String)
}
class AddCityViewController: UIViewController {
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Properties
    @IBOutlet weak var cityNameTextField: UITextField!
    
    var delegate: AddWeatherDelegate?
    
    // MARK: - Actions
    
    @IBAction func saveCityButtonPressed() {
        
        if let city = cityNameTextField.text {
            self.delegate?.addWeatherDidSave(newCityName: city)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
