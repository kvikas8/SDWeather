//
//  WeatherData.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import Foundation

protocol WeatherData {
    var temperature: Double { get }
    var temperatureMin: Double { get }
    var temperatureMax: Double { get }
    var windSpeed: Double { get }
}
  
