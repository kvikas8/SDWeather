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
       case notAuthorizedToRequestLocation
       case failedToRequestLocation
       case noWeatherDataAvailable
   }

enum WeatherDataResult {
       case success(ForecastWeatherData)
       case failure(WeatherDataError)
   }

// MARK: - Type Aliases

typealias FetchWeatherDataCompletion = (WeatherDataResult) -> Void



class WeekViewModel {
    
    private let locationService: LocationService?
       
       // MARK: - Initialization
       
       init(locationService: LocationService) {
           // Set Location Service
           self.locationService = locationService
           
         //  super.init()
           
           // Fetch Weather Data
           fetchWeatherData(for: Defaults.location)
           
           // Fetch Location
           fetchLocation()
       }
    
    init(weatherData: [WeatherData]) {
        self.weatherData = weatherData
        self.locationService = nil
        let groupedDictionary = Dictionary(grouping: weatherData, by: { $0.simplifiedDate })
        self.clubbedData = groupedDictionary.compactMap { (arg0) -> ClubbedWeatherData? in
            let (key, value) = arg0
            return ClubbedWeatherData(date: key, hourly: value)
        }
    }
    
    // MARK: - Properties
    var didFetchWeatherData: FetchWeatherDataCompletion?
    
    private var clubbedData: [ClubbedWeatherData]?
    
    var weatherData: [WeatherData]?
    
    
    // MARK: -
    
    var numberOfSections: Int {
        return clubbedData?.count ?? 0
    }
    
    // MARK: - Helper Methods
    
    private func fetchLocation() {
        locationService?.fetchLocation { [weak self] (result) in
            switch result {
            case .success(let location):
                // Fetch Weather Data
                self?.fetchWeatherData(for: location)
            case .failure(let error):
                print("Unable to Fetch Location (\(error))")
                let result: WeatherDataResult = .failure(.notAuthorizedToRequestLocation)
                // Invoke Completion Handler
               self?.didFetchWeatherData?(result)
                
            }
        }
    }
    
   private func fetchWeatherData(for location: Location) {
        // Initialize Weather Request
        let weatherRequest = ForeCastWeatherRequest(baseUrl: WeatherService.authenticatedForcastBaseUrl, location: Defaults.location)
        
        // Create Data Task
        URLSession.shared.dataTask(with: weatherRequest.url) { [weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            
            if let error = error {
                print("Unable to Fetch Weather Data \(error)")
                
                let result: WeatherDataResult = .failure(.noWeatherDataAvailable)

                               // Invoke Completion Handler
                               self?.didFetchWeatherData?(result)
            } else if let data = data {
                // Initialize JSON Decoder
                let decoder = JSONDecoder()
                
                do {
                    // Decode JSON Response
                    let weatherResponse = try decoder.decode(ForecastWeatherResponse.self, from: data)
                    self?.setUp(weatherData: weatherResponse.daily)
                    // Invoke Completion Handler
                   let result: WeatherDataResult = .success(weatherResponse)

                    // Invoke Completion Handler
                    self?.didFetchWeatherData?(result)
                } catch {
                    print("Unable to Decode JSON Response \(error)")
                    
                    // Invoke Completion Handler
                   let result: WeatherDataResult = .failure(.noWeatherDataAvailable)

                                   // Invoke Completion Handler
                                   self?.didFetchWeatherData?(result)
                }
            } else {
                let result: WeatherDataResult = .failure(.noWeatherDataAvailable)

                               // Invoke Completion Handler
                               self?.didFetchWeatherData?(result)
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
