//
//  Configuration.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import Foundation
import CoreLocation
enum Defaults {

    static let location: CLLocation = CLLocation(latitude: 51.509865, longitude: -0.118092)

}

enum WeatherService {

    private static let apiKey = "10bf41f616eb02f9d91dfb54bfded77d"
    private static let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?")!

    static var authenticatedBaseUrl: URL {
        return baseUrl.appending("APPID", value: apiKey)
    }

}
