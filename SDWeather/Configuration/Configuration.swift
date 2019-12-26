//
//  Configuration.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import Foundation

enum Defaults {
    
    static let location = Location(latitude: 51.509865, longitude: -0.118092)
    
}

enum WeatherService {
    
    private static let apiKey = "10bf41f616eb02f9d91dfb54bfded77d"
    private static let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/")!
    
    static var authenticatedForcastBaseUrl: URL {
        return baseUrl.appendingPathComponent("forecast").appending("APPID", value: apiKey).appending("units", value: "imperial")
    }
    
    static var authenticatedCurrentBaseUrl: URL {
        return baseUrl.appendingPathComponent("weather").appending("APPID", value: apiKey).appending("units", value: "imperial")
    }
}
