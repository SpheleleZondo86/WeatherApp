//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Sphelele Zondo on 2018/07/30.
//  Copyright © 2018 SpheleleZondo. All rights reserved.
//

import Foundation

class CurrentWeather {
    private var _weatherType:String!
    var weatherType:String{
        get{
            if _weatherType == nil{
                _weatherType = ""
            }
            return _weatherType
        }
        set{
            _weatherType = newValue
        }
    }
    
    private var _currentTemperature:Double!
    var currentTemperature:Double{
        get{
            if _currentTemperature == nil{
                _currentTemperature = 0.0
            }
            return _currentTemperature
        }
        set{
            _currentTemperature = newValue
        }
    }
    
    private var _minTemperature:Double!
    var minTemperature:Double{
        get{
            if _minTemperature == nil{
                _minTemperature = 0.0
            }
            return _minTemperature
        }
        set{
            _minTemperature = newValue
        }
    }
    
    private var _maxTemperature:Double!
    var maxTemperature:Double{
        get{
            if _maxTemperature == nil{
                _maxTemperature = 0.0
            }
            return _maxTemperature
        }
        set{
            _maxTemperature = newValue
        }
    }
}
