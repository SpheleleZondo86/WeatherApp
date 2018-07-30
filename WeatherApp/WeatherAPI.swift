//
//  WeatherAPI.swift
//  WeatherApp
//
//  Created by Sphelele Zondo on 2018/07/23.
//  Copyright © 2018 SpheleleZondo. All rights reserved.
//

import Foundation

class WeatherAPI {
    let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    let openWeatherMapAPIKey = "e5e2c1d0b67002fc6d5c442b8df987bf"
    var weather = [String:AnyObject]()
    
    func getWeather(city: String){
        let session = URLSession.shared
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")
        let dataTask = session.dataTask(with: weatherRequestURL!,
            completionHandler:{(data,response,error) in
                if let error = error{
                    print("Error:\n\(error)")
                }else{
                    do{
                        self.weather = try JSONSerialization.jsonObject(with:data!, options: .mutableContainers) as! [String:AnyObject]
                    }catch let jsonError as NSError{
                        print("JSON Error: \(jsonError)")
                    }
                }
        })
        dataTask.resume()
    }
}
