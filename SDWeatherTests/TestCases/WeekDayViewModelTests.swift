//
//  WeekDayViewModelTests.swift
//  SDWeatherTests
//
//  Created by Vikas Kumar on 26/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import XCTest
@testable import SDWeather
class WeekDayViewModelTests: XCTestCase {
    // MARK: - Properties

       var viewModel: WeekDayViewModel!
    override func setUp() {
        let data = loadStub(name: "forecast", extension: "json")
        // Initialize JSON Decoder
        let decoder = JSONDecoder()

        // Configure JSON Decoder
        decoder.dateDecodingStrategy = .secondsSince1970

        // Initialize Dark Sky Response
        let weatherResponse = try! decoder.decode(ForecastWeatherResponse.self, from: data)
        viewModel = WeekDayViewModel(weatherData: weatherResponse.daily[0])    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDay() {
        XCTAssertEqual(viewModel.day, "11:30 PM")
    }
    
    func testDate() {
          XCTAssertEqual(viewModel.date, "January 30")
       }
    
    func testTemprature() {
           XCTAssertEqual(viewModel.temperature, "283.8 °F - 283.8 °F")
       }
    
    func testWindSpeed() {
            XCTAssertEqual(viewModel.windSpeed, "7 MPH")
       }
    
    func testDescription() {
           XCTAssertEqual(viewModel.description, "clear sky")
       }
    
}
