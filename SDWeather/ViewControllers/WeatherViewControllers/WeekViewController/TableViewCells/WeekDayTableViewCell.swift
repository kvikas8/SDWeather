//
//  WeekDayTableViewCell.swift
//  SDWeather
//
//  Created by Vikas Kumar on 26/12/19.
//  Copyright © 2019 Vikas Kumar. All rights reserved.
//

import UIKit

class WeekDayTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - Properties
    
    @IBOutlet var dayLabel: UILabel! {
        didSet {
            dayLabel.textColor = UIColor.SDWeather.baseTextColor
            dayLabel.font = UIFont.SDWeather.heavyLarge
        }
    }
    
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.textColor = .black
            descriptionLabel.font = UIFont.SDWeather.lightRegular
        }
    }
    
    @IBOutlet var windSpeedLabel: UILabel! {
        didSet {
            windSpeedLabel.textColor = .black
            windSpeedLabel.font = UIFont.SDWeather.lightSmall
        }
    }
    
    @IBOutlet var temperatureLabel: UILabel! {
        didSet {
            temperatureLabel.textColor = .black
            temperatureLabel.font = UIFont.SDWeather.lightSmall
        }
    }
    
    @IBOutlet var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFit
            iconImageView.tintColor = UIColor.SDWeather.baseTintColor
        }
    }
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure Cell
        selectionStyle = .none
    }
    
    // MARK: - Configuration
    
    func configure(with representable: WeekDayRepresentable) {
        dayLabel.text = representable.day
        descriptionLabel.text = representable.description
        windSpeedLabel.text = representable.windSpeed
        temperatureLabel.text = representable.temperature
    }
    
}
