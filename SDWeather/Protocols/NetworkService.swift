//
//  NetworkService.swift
//  SDWeather
//
//  Created by Vikas Kumar on 26/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import Foundation

protocol NetworkService {

    // MARK: - Type Aliases

    typealias FetchDataCompletion = (Data?, URLResponse?, Error?) -> Void

    // MARK: - Methods

    func fetchData(with url: URL, completionHandler: @escaping FetchDataCompletion)

}
