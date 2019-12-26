//
//  WeatherResponse.swift
//  SDWeather
//
//  Created by Vikas Kumar on 25/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import Foundation

struct ForecastWeatherResponse {

    let cityName: String
    let country: String
    fileprivate let forcasts: [WeatherResponse]
     
    
    private enum CodingKeys: String, CodingKey {
        case city
        case forcasts = "list"
    }
    
    enum CityKeys: String, CodingKey {
        case cityName = "name"
        case country
    }
}



extension ForecastWeatherResponse: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        forcasts = try values.decodeIfPresent([WeatherResponse].self, forKey: .forcasts) ?? []
        
        let cityValues = try values.nestedContainer(keyedBy: CityKeys.self, forKey: .city)
        cityName = try cityValues.decodeIfPresent(String.self, forKey: .cityName) ?? ""
        country = try cityValues.decodeIfPresent(String.self, forKey: .country) ?? ""
    }
    
}


struct WeatherResponse {
    
    let date: Date
    var description = ""
    let temperature: Double
    let temperatureMax: Double
    let temperatureMin: Double
    let humidity: Double
    let windSpeed: Double
    let city: String

    
    private enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
        case wind
        case city = "name"
    }
    
    enum MainKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
        case humidity
        
    }
    
    enum WeatherKeys: String, CodingKey {
        case description
    }
    
    enum WindKeys: String, CodingKey {
        case windSpeed = "speed"
    }
    
}



extension WeatherResponse: Decodable {
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(Date.self, forKey: .date) ?? Date()
        city = try values.decodeIfPresent(String.self, forKey: .city) ?? ""

        let mainValues = try values.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        temperature = try mainValues.decodeIfPresent(Double.self, forKey: .temperature) ?? 0.0
        temperatureMin = try mainValues.decodeIfPresent(Double.self, forKey: .temperatureMin) ?? 0.0
        temperatureMax = try mainValues.decodeIfPresent(Double.self, forKey: .temperatureMax) ?? 0.0
        humidity = try mainValues.decodeIfPresent(Double.self, forKey: .humidity) ?? 0.0
     
        var weatherValues = try values.nestedUnkeyedContainer(forKey:.weather)

        while (!weatherValues.isAtEnd) {
            let weatherInfo = try weatherValues.nestedContainer(keyedBy: WeatherKeys.self)
            description = try weatherInfo.decodeIfPresent(String.self, forKey: .description) ?? ""
        }
        
        let windValues = try values.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
        windSpeed = try windValues.decodeIfPresent(Double.self, forKey: .windSpeed) ?? 0.0
    }
    
    
}


extension WeatherResponse: WeatherData {
    var time: Date {
        return date
    }
    
    var simplifiedDate: String {
        // Configure Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        return dateFormatter.string(from: time)
    }
}

extension ForecastWeatherResponse: ForecastWeatherData {
    var daily: [WeatherData] {
        return forcasts
    }
}
