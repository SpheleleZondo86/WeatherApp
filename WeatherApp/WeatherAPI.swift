//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Sphelele Zondo on 2018/07/23.
//  Copyright © 2018 SpheleleZondo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherAPI {
    let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    let openWeatherMapAPIKey = "e5e2c1d0b67002fc6d5c442b8df987bf"
    var currentWeather = CurrentWeather()
    
    func downloadCurrentWeather(completed: @escaping DownloadComplete){
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?lat=\(Location.sharedInstance.latitude.roundOff(toPlaces: 2))&lon=\(Location.sharedInstance.longitude.roundOff(toPlaces: 2))&appid=\(openWeatherMapAPIKey)")
        Alamofire.request(weatherRequestURL!).responseJSON{(response) in
            print(response)
            let json = JSON(response.result.value!)
            self.currentWeather.weatherType = json["weather"][0]["main"].stringValue
            self.currentWeather.currentTemperature = (json["main"]["temp"].double?.roundOff(toPlaces: 2))!
            self.currentWeather.minTemperature = (json["main"]["temp_min"].double?.roundOff(toPlaces: 2))!
            self.currentWeather.maxTemperature = (json["main"]["temp_max"].double?.roundOff(toPlaces: 2))!
            completed()
        }
    }
}
