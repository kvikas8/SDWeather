//
//  WeekViewModelTests.swift
//  SDWeatherTests
//
//  Created by Vikas Kumar on 26/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import XCTest
@testable import SDWeather
class WeekViewModelTests: XCTestCase {

    // MARK: - Properties

    var viewModel: WeekViewModel!
    
    override func setUp() {
       let data = loadStub(name: "forecast", extension: "json")
        // Initialize JSON Decoder
        let decoder = JSONDecoder()

        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .secondsSince1970

        // Initialize Dark Sky Response
        let weatherResponse = try! decoder.decode(ForecastWeatherResponse.self, from: data)
        viewModel = WeekViewModel(weatherData: weatherResponse.daily)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Tests for Number of Section

    func testNumberOfSections() {
        XCTAssertEqual(viewModel.numberOfSections, 1)
    }
    
    // MARK: - Tests for Number of Section

       func testNumberOfDays() {
        let days = viewModel.numberOfDays(in: 0)
        XCTAssertEqual(days, 1)
       }
    
    // MARK: - Tests for title of Section

    func testTitleForSection() {
        let title = viewModel.title(for: 0)
        XCTAssertEqual(title, "Monday, Jan 30")
    }
 
    
    // MARK: - Tests for View Model for Index

    func testViewModelForIndex() {
        let weekDayViewModel = viewModel.viewModel(for: 0, section: 0)!
        
        XCTAssertEqual(weekDayViewModel.day, "11:30 PM")
        XCTAssertEqual(weekDayViewModel.date, "January 30")
        XCTAssertEqual(weekDayViewModel.temperature, "283.8 °F - 283.8 °F")
        XCTAssertEqual(weekDayViewModel.windSpeed, "7 MPH")
        XCTAssertEqual(weekDayViewModel.description, "clear sky")
      
    }
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
