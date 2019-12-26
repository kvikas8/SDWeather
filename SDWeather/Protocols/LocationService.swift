//
//  LocationService.swift
//  SDWeather
//
//  Created by Vikas Kumar on 26/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import Foundation

enum LocationServiceResult {
    case success(Location)
    case failure(LocationServiceError)
}
enum LocationServiceError: Error {
    case notAuthorizedToRequestLocation
}

protocol LocationService {
    
    // MARK: - Type Aliases
    
   typealias FetchLocationCompletion = (LocationServiceResult) -> Void
    
    // MARK: - Methods
    
    func fetchLocation(completion: @escaping FetchLocationCompletion)
    
}
