//
//  WeekViewModelAsyncTests.swift
//  SDWeatherTests
//
//  Created by Vikas Kumar on 26/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import XCTest
@testable import SDWeather
class WeekViewModelAsyncTests: XCTestCase {
    
    var viewModel: WeekViewModel!
    
    var locationService: MockLocationService!
    var networkService: MockNetworkService!
    
    override func setUp() {
        networkService = MockNetworkService()
        let data = loadStub(name: "forecast", extension: "json")
        networkService.data = data;
        
        // Initialize Mock Location Service
        locationService = MockLocationService()
        
        viewModel = WeekViewModel(networkService: networkService, locationService: locationService)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchingSuccess() {
        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        
        // Install Handler
        viewModel.didFetchWeatherData = { (result) in
            if case .success(let weatherData) = result {
                print(weatherData)
                XCTAssertEqual(weatherData.daily.count, 1)
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
        viewModel.fetchWeather()
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFailedToFetchLocation() {
        // Define Expectation
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        locationService.location = nil
        
        // Install Handler
        viewModel.didFetchWeatherData = { (result) in
            if case .failure(let error) = result {
                XCTAssertEqual(error, WeatherDataError.notAuthorizedToRequestLocation)
                // Fulfill Expectation
                expectation.fulfill()
            }
        }
        
        // Invoke Method Under Test
        viewModel.fetchWeather()
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFailedToFetchWeatherData_RequestFailed() {
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
        viewModel.fetchWeather()
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFailedToFetchWeatherData_InvalidResponse() {
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
        viewModel.fetchWeather()
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testFailedToFetchWeatherData_NoErrorNoResponse() {
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
        viewModel.fetchWeather()
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
}
