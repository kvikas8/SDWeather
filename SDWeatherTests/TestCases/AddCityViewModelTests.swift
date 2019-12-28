//
//  AddCityViewModelTests.swift
//  SDWeatherTests
//
//  Created by Vikas Kumar on 28/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import XCTest
@testable import SDWeather
class AddCityViewModelTests: XCTestCase {

    var viewModel: AddCityViewModel!
    
    override func setUp() {
       viewModel = AddCityViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   func testAddingCitySuccess() {
        // Define Expectation
    let expectation = XCTestExpectation(description: "Adding City")
       
    viewModel.didEnteredCities = { (success, errorMessage, cities) in
        XCTAssertEqual(success, true)
        XCTAssertEqual(errorMessage, "")
        XCTAssertEqual(cities.count, 3)
        expectation.fulfill()
    }
        // Invoke Method Under Test
        viewModel.addCities("Dubai,London,Cupertino")
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testAddingLessthanThreeCitiesFailure() {
        // Define Expectation
    let expectation = XCTestExpectation(description: "Adding City Failure")
       
    viewModel.didEnteredCities = { (success, errorMessage, cities) in
        XCTAssertEqual(success, false)
        XCTAssertNotEqual(errorMessage.count, 0)
        XCTAssertEqual(cities.count, 2)
        expectation.fulfill()
    }
        // Invoke Method Under Test
        viewModel.addCities("Dubai,London")
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testAddingMorethanSevenCitiesFailure() {
        // Define Expectation
    let expectation = XCTestExpectation(description: "Adding City Failure")
       
    viewModel.didEnteredCities = { (success, errorMessage, cities) in
        XCTAssertEqual(success, false)
        XCTAssertNotEqual(errorMessage.count, 0)
        XCTAssertEqual(cities.count, 8)
        expectation.fulfill()
    }
        // Invoke Method Under Test
        viewModel.addCities("Dubai,London,Delhi,Cupertino,Noida,Banglore,Gurugram,Mumbai")
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testAddingBlankStringFailure() {
        // Define Expectation
    let expectation = XCTestExpectation(description: "Adding City Failure")
       
    viewModel.didEnteredCities = { (success, errorMessage, cities) in
        XCTAssertEqual(success, false)
        XCTAssertNotEqual(errorMessage.count, 0)
        expectation.fulfill()
    }
        // Invoke Method Under Test
        viewModel.addCities("")
        
        // Wait for Expectation to Be Fulfilled
        wait(for: [expectation], timeout: 2.0)
    }

}
