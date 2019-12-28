//
//  CurrentListViewModelAsyncTests.swift
//  SDWeatherTests
//
//  Created by Vikas Kumar on 27/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import XCTest
@testable import SDWeather
class CurrentListViewModelAsyncTests: XCTestCase {
    
    var networkService: MockNetworkService!
    var viewModel: CurrentListViewModel!
    
    override func setUp() {
        
        networkService = MockNetworkService()
        
        let data = loadStub(name: "current", extension: "json")
        
        networkService.data = data;
        
        viewModel = CurrentListViewModel(networkService: networkService)
        
    }
    
    func testFetchingForCitySuccess() {
        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        var successCount = 0
        // Install Handler
        viewModel.didFetchWeatherData = { (result) in
            if case .success(let weatherData) = result {
                successCount += 1
                XCTAssertEqual(weatherData.city, "London")
                if successCount == 3 {
                // Fulfill Expectation
                    expectation.fulfill() }
            }
        }
        
        // Invoke Method Under Test
        viewModel.addWeatherViewModel(for: ["London","London","London"])
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testToFetchWeatherDataForCityRequestFailed() {
        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        // Configure Network Service
        networkService.error = NSError(domain: "SDWeather.network.service", code: 1, userInfo: nil)
        
        // Install Handler
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error) = result {
                XCTAssertEqual(error, WeatherDataError.noWeatherDataAvailable)
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
        viewModel.addWeatherViewModel(for: ["London","London","London"])
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testToFetchWeatherDataForCityInvalidResponse() {
        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        // Configure Network Service
        networkService.data = "data".data(using: .utf8)
        
        // Install Handler
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error) = result {
                XCTAssertEqual(error, WeatherDataError.noWeatherDataAvailable)
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
         viewModel.addWeatherViewModel(for: ["London","London","London"])
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testToFetchWeatherDataForCityNoErrorNoResponse() {
        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        // Configure Network Service
        networkService.data = nil
        
        // Install Handler
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error) = result {
                XCTAssertEqual(error, WeatherDataError.noWeatherDataAvailable)
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
         viewModel.addWeatherViewModel(for: ["London","London","London"])
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
}
