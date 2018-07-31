//
//  ForecastWeather.swift
//  WeatherApp
//
//  Created by Sphelele Zondo on 2018/07/31.
//  Copyright © 2018 SpheleleZondo. All rights reserved.
//

import Foundation

class ForecastWeather {
    
    private var _day:String!
    var day:String{
        get{
            if _day == nil{
                _day = ""
            }
            return _day
        }
        set{
            _day = newValue
        }
    }
    
    private var _weatherIcon:String!
    var weatherIcon:String{
        get{
            if _weatherIcon == nil{
                _weatherIcon = ""
            }
            return _weatherIcon
        }
        set{
            _weatherIcon = newValue
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
    
    init(forecastDictinery:Dictionary<String, AnyObject>){
        if let main = forecastDictinery["main"] as? Dictionary<String,AnyObject>{
            if let temp = main["temp"] as? Double{
                self._temperature = temp.roundOff(toPlaces: 2)
            }
        }
    }
}
