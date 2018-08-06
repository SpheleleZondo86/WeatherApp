//
//  ForecastWeather.swift
//  WeatherApp
//
//  Created by Sphelele Zondo on 2018/07/31.
//  Copyright © 2018 SpheleleZondo. All rights reserved.
//

import Foundation

class ForecastWeather {
    
    private var _date:String?
    var date:String{
        get{
            if _date == nil{
                _date = ""
            }
            return _date!
        }
        set{
            _date = newValue
        }
    }
    
    private var _temperature:Double!
    var temperature:Double{
        get{
            if _temperature == nil{
                _temperature = 0.0
            }
            return _temperature
        }
        set{
            _temperature = newValue
        }
    }
    
    private var _weatherDescription:String!
    var weatherDescription:String{
        get{
            if _weatherDescription == nil{
                _weatherDescription = ""
            }
            return _weatherDescription
        }
        set{
            _weatherDescription = newValue
        }
    }
    
    init(item:Dictionary<String,AnyObject>) {
        if let date = item["Date"] as? String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
            let formattedDate = dateFormatter.date(from: date)
            self._date = formattedDate?.dayOfWeek() 
        }
        
        if let temperature = item["Temperature"] as? Dictionary<String,AnyObject>{
            if let max = temperature["Maximum"] as? Dictionary<String,AnyObject>{
                if let rawValue = max["Value"] as? Double{
                    self._temperature = ((rawValue - 32)/1.8).roundOff(toPlaces: 0)
                }
            }
        }
        
        if let day = item["Day"] as? Dictionary<String,AnyObject>{
            if let description = day["IconPhrase"] as? String{
                self._weatherDescription = description
            }
        }
    }
}
