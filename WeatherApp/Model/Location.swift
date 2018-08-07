//
//  Location.swift
//  WeatherApp
//
//  Created by Sphelele Zondo on 2018/07/31.
//  Copyright © 2018 SpheleleZondo. All rights reserved.
//

import Foundation

class Location {
    static var sharedInstance = Location()
    
    var latitude:Double!
    var longitude:Double!
    
    private init(){
        
    }
}
