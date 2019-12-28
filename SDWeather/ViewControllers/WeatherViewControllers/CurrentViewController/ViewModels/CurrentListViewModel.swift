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
    
    private let fetchGroup = DispatchGroup()
    
    private let errorSyncQueue = DispatchQueue(label: "FetchingQueue.ErrorSync")
    
    private var anyError: WeatherDataError?
    
    private let fetchingQueue = DispatchQueue(label: "FetchingQueue", qos: .userInitiated, attributes: [.concurrent])
    
    var didFetchWeatherData: CurrentWeatherDataCompletion?
    
    var workDayViewModels: [WeekDayViewModel] = []
    
    
    // MARK: - Initializers
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Methods
    func addWeatherViewModel(for cities: [String]) {
        for city in cities {
            let fetchItem =  fetchWeatherData(for: city)
            self.fetchGroup.enter()
            fetchingQueue.async(execute: fetchItem)
        }
        self.fetchGroup.notify(queue: .main) {
            guard let error = self.anyError else {return}
            let result: CurrentWeatherDataResult = .failure(error)
            //  Invoke Completion Handler
            self.didFetchWeatherData?(result)
            self.anyError = nil
        }
    }
    
    private func fetchWeatherData(for city: String) -> DispatchWorkItem {
        let fetchItem =   DispatchWorkItem {
            // Initialize Weather Request
            let weatherRequest = CurrentWeatherRequest.init(baseUrl: WeatherService.authenticatedCurrentBaseUrl, city: city)
            // Create Data Task
            self.networkService?.fetchData(with: weatherRequest.url) { [weak self] (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    print("Status Code: \(response.statusCode)")
                }
                
                if let error = error {
                    print("Unable to Fetch Weather Data \(error)")
                    self?.errorSyncQueue.sync {
                        self?.anyError = .noWeatherDataAvailable
                    }
                } else if let data = data {
                    // Initialize JSON Decoder
                    let decoder = JSONDecoder()
                    
                    do {
                        // Decode JSON Response
                        let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                        // Invoke Completion Handler
                        let result: CurrentWeatherDataResult = .success(weatherResponse)
                        
                        DispatchQueue.main.async {
                            self?.workDayViewModels.append(WeekDayViewModel(weatherData: weatherResponse))
                            self?.didFetchWeatherData?(result)
                        }
                        
                    } catch {
                        print("Unable to Decode JSON Response \(error)")
                        
                        self?.errorSyncQueue.sync {
                            self?.anyError = .noWeatherDataAvailable
                        }
                    }
                } else {
                    
                    self?.errorSyncQueue.sync {
                        self?.anyError = .noWeatherDataAvailable
                    }
                }
                self?.fetchGroup.leave()
            }
        }
        return fetchItem;
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return self.workDayViewModels.count
    }
    
    func modelAt(_ index: Int) -> WeekDayViewModel {
        return self.workDayViewModels[index]
    }
}
