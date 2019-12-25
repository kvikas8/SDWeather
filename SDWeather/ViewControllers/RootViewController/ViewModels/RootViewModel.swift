//
//  RootViewModel.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import Foundation

class RootViewModel {
    
    // MARK: - Types

   enum WeatherDataError: Error {
        case noWeatherDataAvailable
    }
    // MARK: - Type Aliases
    
    typealias DidFetchWeatherDataCompletion = (WeatherResponse?, WeatherDataError?) -> Void
    
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
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }

            if let error = error {
                print("Unable to Fetch Weather Data \(error)")

                self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
            } else if let data = data {
                // Initialize JSON Decoder
                let decoder = JSONDecoder()

                do {
                    // Decode JSON Response
                    let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                    // Invoke Completion Handler
                    self?.didFetchWeatherData?(weatherResponse, nil)
                } catch {
                    print("Unable to Decode JSON Response \(error)")

                    // Invoke Completion Handler
                    self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
                }
            } else {
                self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
            }
        }.resume()
    }
    
}
