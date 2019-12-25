//
//  WeatherResponse.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import Foundation

struct WeatherResponse: Decodable {
    let mainConditions: Conditions
    let wind: Wind
  
    enum CodingKeys: String, CodingKey {
      case mainConditions = "main"
      case wind
    }
}

struct Conditions: Decodable {
    let temperature: Double
    let temperatureMin: Double
    let temperatureMax: Double
    
    enum CodingKeys: String, CodingKey {
         case temperature = "temp"
         case temperatureMax = "temp_max"
         case temperatureMin = "temp_min"
       }
}

struct Wind: Codable {
    let speed: Date
}
