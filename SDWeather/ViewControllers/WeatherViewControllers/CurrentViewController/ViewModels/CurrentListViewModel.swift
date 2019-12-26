//
//  CurrentViewModel.swift
//  SDWeather
//
//  Created by Vikas Kumar on 26/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import Foundation
enum CurrentWeatherDataResult {
    case success(WeatherData)
    case failure(WeatherDataError)
}

// MARK: - Type Aliases

typealias CurrentWeatherDataCompletion = (CurrentWeatherDataResult) -> Void


class CurrentListViewModel {
    
    // MARK: - Properties
    private let networkService: NetworkService?
    
    var didFetchWeatherData: CurrentWeatherDataCompletion?
    
    var workDayViewModels: [WeekDayViewModel] = []
    
    
    // MARK: - Initializers
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func addWeatherViewModel(for city: String) {
        fetchWeatherData(for: city)
    }
    
    private func fetchWeatherData(for city: String) {
        // Initialize Weather Request
        let weatherRequest = CurrentWeatherRequest.init(baseUrl: WeatherService.authenticatedCurrentBaseUrl, city: city)
        
        // Create Data Task
        networkService?.fetchData(with: weatherRequest.url) { [weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            
            if let error = error {
                print("Unable to Fetch Weather Data \(error)")
                
                let result: CurrentWeatherDataResult = .failure(.noWeatherDataAvailable)
                
                // Invoke Completion Handler
                self?.didFetchWeatherData?(result)
            } else if let data = data {
                // Initialize JSON Decoder
                let decoder = JSONDecoder()
                
                do {
                    // Decode JSON Response
                    let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                    // Invoke Completion Handler
                    let result: CurrentWeatherDataResult = .success(weatherResponse)
                    self?.workDayViewModels.append(WeekDayViewModel(weatherData: weatherResponse))
                    // Invoke Completion Handler
                    self?.didFetchWeatherData?(result)
                } catch {
                    print("Unable to Decode JSON Response \(error)")
                    
                    // Invoke Completion Handler
                    let result: CurrentWeatherDataResult = .failure(.noWeatherDataAvailable)
                    
                    // Invoke Completion Handler
                    self?.didFetchWeatherData?(result)
                }
            } else {
                let result: CurrentWeatherDataResult = .failure(.noWeatherDataAvailable)
                
                // Invoke Completion Handler
                self?.didFetchWeatherData?(result)
            }
        }
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return self.workDayViewModels.count
    }
    
    func modelAt(_ index: Int) -> WeekDayViewModel {
        return self.workDayViewModels[index]
    }
}
