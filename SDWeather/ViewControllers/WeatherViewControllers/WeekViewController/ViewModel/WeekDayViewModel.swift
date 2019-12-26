//
//  WeekDayViewModel.swift
//  SDWeather
//
//  Created by Vikas Kumar on 26/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import UIKit

struct WeekDayViewModel {
    
    // MARK: - Properties
    
    let weatherData: WeatherData
    
    // MARK: -
    
    private let dateFormatter = DateFormatter()
    
    // MARK: -
    
    var day: String {
        // Configure Date Formatter
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: weatherData.time)
    }
    
    var date: String {
        // Configure Date Formatter
        dateFormatter.dateFormat = "MMMM d"
        
        return dateFormatter.string(from: weatherData.time)
    }
    
    var temperature: String {
        let min = String(format: "%.1f °F", weatherData.temperatureMin)
        let max = String(format: "%.1f °F", weatherData.temperatureMax)
        
        return "\(min) - \(max)"
    }
    
    var windSpeed: String {
        return String(format: "%.f MPH", weatherData.windSpeed)
    }
    
    var description: String {
        return weatherData.description
    }
    
    var cityName: String {
        return weatherData.city
    }
}

extension WeekDayViewModel: WeekDayRepresentable {
    
    
}

