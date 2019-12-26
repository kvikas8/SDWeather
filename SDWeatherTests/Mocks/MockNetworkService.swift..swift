//
//  MockNetworkService.swift..swift
//  SDWeatherTests
//
//  Created by Vikas Kumar on 26/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import Foundation

@testable import SDWeather

class MockNetworkService: NetworkService {
    
    // MARK: - Properties
    
    var data: Data?
    var error: Error?
    var statusCode: Int = 200
    
    // MARK: - Network Service
    
    func fetchData(with url: URL, completionHandler: @escaping NetworkService.FetchDataCompletion) {
        // Create Response
        let response = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        
        // Invoke Handler
        completionHandler(data, response, error)
    }
    
}
