//
//  WeatherRequest.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import Foundation

protocol WeatherRequest {
    var baseUrl: URL { get }
    // MARK: -
    
    var url: URL { get }
}

struct ForeCastWeatherRequest: WeatherRequest {
    
    // MARK: - Properties
    
    let baseUrl: URL
    
    // MARK: -
    
    let location: Location
    
    // MARK: -
    
    private var latitude: Double {
        return location.latitude
    }
    
    private var longitude: Double {
        return location.longitude
    }
    
    // MARK: -
    
    var url: URL {
        return baseUrl.appending("lat", value: "\(latitude)").appending("lon", value: "\(longitude)")
    }
}

struct CurrentWeatherRequest: WeatherRequest {
    
    // MARK: - Properties
    
    let baseUrl: URL
    
    // MARK: -
    
    let city: String
    
    
    // MARK: -
    
    var url: URL {
        return baseUrl.appending("q", value: city)
    }
}
