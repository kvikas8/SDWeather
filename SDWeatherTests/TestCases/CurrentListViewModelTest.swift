//
//  CurrentListViewModelTest.swift
//  SDWeatherTests
//
//  Created by Vikas Kumar on 26/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import XCTest
@testable import SDWeather
class CurrentListViewModelTest: XCTestCase {

    var viewModel = CurrentListViewModel()
    
    override func setUp() {
           let data = loadStub(name: "current", extension: "json")
             // Initialize JSON Decoder
             let decoder = JSONDecoder()

             // Configure JSON Decoder
             decoder.dateDecodingStrategy = .secondsSince1970
        
        let weatherResponse = try! decoder.decode(WeatherResponse.self, from: data)
        viewModel.workDayViewModels.append(WeekDayViewModel(weatherData: weatherResponse))
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNumberOfRowa() {
        XCTAssertEqual(viewModel.numberOfRows(0), 1)
    }
    
    func testViewModelForIndex() {
           let weekDayViewModel = viewModel.modelAt(0)
           XCTAssertEqual(weekDayViewModel.day, "11:30 PM")
           XCTAssertEqual(weekDayViewModel.date, "January 30")
           XCTAssertEqual(weekDayViewModel.temperature, "283.8 °F - 283.8 °F")
           XCTAssertEqual(weekDayViewModel.windSpeed, "7 MPH")
           XCTAssertEqual(weekDayViewModel.description, "clear sky")
       }
}
