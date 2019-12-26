//
//  CurrentWeatherCell.swift
//  SDWeather
//
//  Created by Vikas Kumar on 26/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import UIKit

class CurrentWeatherCell: UITableViewCell {
    // MARK: - Static Properties
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    func configure(with representable: WeekDayRepresentable) {
        cityNameLabel.text = representable.cityName
        temperatureLabel.text = representable.temperature
        descriptionLabel.text = representable.description
        windLabel.text = representable.windSpeed
    }
}
