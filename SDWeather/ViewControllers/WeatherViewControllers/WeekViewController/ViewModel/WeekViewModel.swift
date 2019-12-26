//
//  WeekViewModel.swift
//  SDWeather
//
//  Created by Vikas Kumar on 26/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import Foundation
// MARK: - Types

enum WeatherDataError: Error {
    case noWeatherDataAvailable
}
// MARK: - Type Aliases

typealias DidFetchWeatherDataCompletion = (ForecastWeatherData?, WeatherDataError?) -> Void



class WeekViewModel {
    
    // MARK: - Initialization
    init() {
        // Fetch Weather Data
        fetchWeatherData()
    }
    
    // MARK: - Properties
    var didFetchWeatherData: DidFetchWeatherDataCompletion?
    
    private var clubbedData: [ClubbedWeatherData]?
    
    var weatherData: [WeatherData]?
    
    // MARK: -
    
    var numberOfSections: Int {
        return clubbedData?.count ?? 0
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
                    let weatherResponse = try decoder.decode(ForecastWeatherResponse.self, from: data)
                    self?.setUp(weatherData: weatherResponse.daily)
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
    
    func setUp(weatherData: [WeatherData]) {
        self.weatherData = weatherData
        let groupedDictionary = Dictionary(grouping: weatherData, by: { $0.simplifiedDate })
        self.clubbedData = groupedDictionary.compactMap { (arg0) -> ClubbedWeatherData? in
            let (key, value) = arg0
            return ClubbedWeatherData(date: key, hourly: value)
        }
    }
    
    
    // MARK: - Methods
    
    func numberOfDays(in section: Int) -> Int {
        let cData = clubbedData?[section]
        return cData?.hourly.count ?? 0
    }
    
    func title(for section: Int) -> String {
        let cData = clubbedData?[section]
        return cData?.date ?? ""
    }
    
    func viewModel(for index: Int, section: Int) -> WeekDayViewModel? {
        guard let cData = clubbedData?[section] else {return nil}
        return WeekDayViewModel(weatherData: cData.hourly[index])
    }
    
}

fileprivate struct ClubbedWeatherData {
    let date: String
    let hourly: [WeatherData]
}
