//
//  Extensions.swift
//  WeatherApp
//
//  Created by Sphelele Zondo on 2018/07/30.
//  Copyright © 2018 SpheleleZondo. All rights reserved.
//

import Foundation

extension Double{
    func roundOff(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded()/divisor
    }
}
