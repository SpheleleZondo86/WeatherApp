//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Sphelele Zondo on 2018/07/31.
//  Copyright © 2018 SpheleleZondo. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    func setupCell(forecast:ForecastWeather) {
        self.dayLabel.text = forecast.date
        self.temperatureLabel.text = "\(Int(forecast.temperature))"
        switch forecast.weatherDescription {
        case "Sunny":
            self.weatherIcon.image = UIImage(named: "clear")
        case "Mostly Sunny":
            self.weatherIcon.image = UIImage(named: "clear")
        case "Clear":
            self.weatherIcon.image = UIImage(named: "clear")
        case "Mostly Clear":
            self.weatherIcon.image = UIImage(named: "clear")
        case "Rainy":
            self.weatherIcon.image = UIImage(named: "rain")
        default:
            self.weatherIcon.image = UIImage(named: "partlysunny")
        }
    }
}
