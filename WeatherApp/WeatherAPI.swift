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
    
    static let shared = WeatherAPI()
    private init(){
        
    }
    
    var currentWeather = CurrentWeather()
    var weatherForecast:ForecastWeather!
    var focustArray = [ForecastWeather]()
    var locationKey = ""
    
    func downloadCurrentWeather(completed: @escaping DownloadComplete){
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)weather?lat=\(Location.sharedInstance.latitude.roundOff(toPlaces: 2))&lon=\(Location.sharedInstance.longitude.roundOff(toPlaces: 2))&appid=\(openWeatherMapAPIKey)")
        Alamofire.request(weatherRequestURL!).responseJSON{(response) in
            //print(response)
            let json = JSON(response.result.value!)
            self.currentWeather.weatherType = json["weather"][0]["main"].stringValue
            self.currentWeather.currentTemperature = (json["main"]["temp"].double?.roundOff(toPlaces: 2))!
            self.currentWeather.minTemperature = (json["main"]["temp_min"].double?.roundOff(toPlaces: 2))!
            self.currentWeather.maxTemperature = (json["main"]["temp_max"].double?.roundOff(toPlaces: 2))!
            completed()
        }
    }
    
    func downloadLocationKey(completed: @escaping DownloadComplete){
        let query = "\(Location.sharedInstance.latitude.roundOff(toPlaces: 2)),\(Location.sharedInstance.longitude.roundOff(toPlaces: 2))"
        let weatherRequestURL = URL(string: "\(acuWeatherBaseURL)locations/v1/cities/geoposition/search?apikey=\(acuWeatherAPIKey)&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")")
        Alamofire.request(weatherRequestURL!).responseJSON{ (response) in
            let json = JSON(response.result.value!)
            self.locationKey = json["Key"].rawString()!
            completed()
        }
    }
    
    func downloadWeatherFocust(completed: @escaping DownloadComplete){
        downloadLocationKey {
            let weatherRequestURL = URL(string: "\(acuWeatherBaseURL)forecasts/v1/daily/5day/\(self.locationKey)?apikey=\(acuWeatherAPIKey)")
            Alamofire.request(weatherRequestURL!).responseJSON{ (response) in
                let json = JSON(response.result.value!)
                let dailyForecasts = json["DailyForecasts"].arrayObject as? [Dictionary<String,AnyObject>]
                for item in dailyForecasts!{
                    self.weatherForecast = ForecastWeather(item: item)
                    self.focustArray.append(self.weatherForecast)
                }
                completed()
            }
        }
    }
}
