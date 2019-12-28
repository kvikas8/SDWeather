//
//  AddCityViewModel.swift
//  SDWeather
//
//  Created by Vikas Kumar on 28/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import Foundation

// MARK: - Type Aliases

typealias CitiesValidationHandler = (Bool, String, [ String ]) -> Void

class AddCityViewModel {

    var didEnteredCities: CitiesValidationHandler?
    
    func addCities(_ cityString: String) {
        var charset = CharacterSet.whitespacesAndNewlines
        charset.insert(charactersIn: ",")
        let trimmedCityString: String = cityString.trimmingCharacters(in: charset)
        let cities = trimmedCityString.components(separatedBy: ",")
        
        var errorString = ""
        if cities.count < 3 || cities.count > 7 {
            errorString = "You must enter minimum 3 cities and maximum 7 cities"
            didEnteredCities?(false, errorString, cities)
        } else {
            didEnteredCities?(true, errorString, cities)
        }
    }
}
