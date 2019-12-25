//
//  WeatherResponse.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import Foundation

struct WeatherResponse: Decodable {
    fileprivate let mainConditions: Conditions
   fileprivate let wind: Wind
  
    enum CodingKeys: String, CodingKey {
      case mainConditions = "main"
      case wind
    }
}

struct Conditions: Decodable {
   fileprivate let temperature: Double
   fileprivate let temperatureMin: Double
   fileprivate let temperatureMax: Double
    
    enum CodingKeys: String, CodingKey {
         case temperature = "temp"
         case temperatureMax = "temp_max"
         case temperatureMin = "temp_min"
       }
}

struct Wind: Codable {
    fileprivate let speed: Double
}

extension WeatherResponse: WeatherData {
    var temperature: Double {
        return mainConditions.temperature
    }
    
    var temperatureMin: Double {
        return mainConditions.temperatureMin
    }
    
    var temperatureMax: Double {
        return mainConditions.temperatureMax
    }
    
    var windSpeed: Double {
        return wind.speed
    }
}
