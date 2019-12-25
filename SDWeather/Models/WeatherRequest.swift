//
//  WeatherRequest.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherRequest {
    
    // MARK: - Properties
    
    let baseUrl: URL
    
    // MARK: -
    
    let location: CLLocation
    
    // MARK: -
    
    private var latitude: Double {
        return location.coordinate.latitude
    }
    
    private var longitude: Double {
        return location.coordinate.longitude
    }
    
    // MARK: -
    
    var url: URL {
        return baseUrl.appending("lat", value: "\(latitude)").appending("lon", value: "\(longitude)")
    }
    
}
