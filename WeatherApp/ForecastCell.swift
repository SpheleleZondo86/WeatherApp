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
    
    func setupCell(day:String, icon:UIImage, temperature:Int) {
        self.dayLabel.text = day
        self.temperatureLabel.text = "\(temperature)"
        self.weatherIcon.image = icon
    }
}
