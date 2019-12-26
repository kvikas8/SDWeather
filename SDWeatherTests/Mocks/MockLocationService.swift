//
//  MockLocationService.swift
//  SDWeatherTests
//
//  Created by Vikas Kumar on 26/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import Foundation
@testable import SDWeather

class MockLocationService: LocationService {

    // MARK: - Properties

    var location: Location? = Location(latitude: 0.0, longitude: 0.0)

    // MARK: -

    var delay: TimeInterval = 0.0

    // MARK: - Location Service

    func fetchLocation(completion: @escaping LocationService.FetchLocationCompletion) {
    
        // Create Result
        let result: LocationServiceResult
        
        if let location = location {
            result = .success(location)
        } else {
            result = .failure(.notAuthorizedToRequestLocation)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            // Invoke Handler
            completion(result)
        }
    }
    
}
