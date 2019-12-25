//
//  RootViewModel.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import Foundation

class RootViewModel {
    
    // MARK: - Type Aliases
    
    typealias DidFetchWeatherDataCompletion = (Data?, Error?) -> Void
    
    // MARK: - Properties
    
    var didFetchWeatherData: DidFetchWeatherDataCompletion?
    
    // MARK: - Initialization
    
    init() {
        // Fetch Weather Data
        fetchWeatherData()
    }
    
    // MARK: - Helper Methods
    
    private func fetchWeatherData() {
        // Initialize Weather Request
        let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseUrl, location: Defaults.location)
        
        // Create Data Task
        URLSession.shared.dataTask(with: weatherRequest.url) { [weak self] (data, response, error) in
            if let error = error {
                self?.didFetchWeatherData?(nil, error)
            } else if let data = data {
                self?.didFetchWeatherData?(data, nil)
            } else {
                self?.didFetchWeatherData?(nil, nil)
            }
        }.resume()
    }
    
}
