//
//  UIViewController.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Static Properties
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    func presentAlert(of alertType: AlertType) {
        // Helpers
        let title: String
        let message: String
        
        switch alertType {
        case .notAuthorizedToRequestLocation:
            title = "Unable to Fetch Weather Data for Your Location"
            message = "SDWeather is not authorized to access your current location. This means it's unable to show you the weather for your current location. You can grant SDWeather access to your current location in the Settings application."
        case .failedToRequestLocation:
            title = "Unable to Fetch Weather Data for Your Location"
            message = "SDWeather is not able to fetch your current location due to a technical issue."
        case .noWeatherDataAvailable:
            title = "Unable to Fetch Weather Data"
            message = "The application is unable to fetch weather data. Please make sure your device is connected over Wi-Fi or cellular."
        case .dataNotAvailableForAllCities:
            title = "Unable to Fetch Weather Data for some or all the entered cities"
            message = "The application is unable to fetch weather data for some or all the entered cities. Please make sure your device is connected over Wi-Fi or cellular."
            
        }
        
        DispatchQueue.main.async {
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
