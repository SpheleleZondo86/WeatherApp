//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sphelele Zondo on 2018/07/19.
//  Copyright © 2018 SpheleleZondo. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    var locatioManager = CLLocationManager()
    let weatherApi = WeatherAPI()


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locatioManager.delegate = self
        locatioManager.requestWhenInUseAuthorization()
        locatioManager.desiredAccuracy = kCLLocationAccuracyBest
        locatioManager.startUpdatingLocation()
        locatioManager.startMonitoringSignificantLocationChanges()
    }
    
    func getWeatherData() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus(){
            case .authorizedAlways, .authorizedWhenInUse:
                print("Authorized")
                let lat = locatioManager.location?.coordinate.latitude
                let long = locatioManager.location?.coordinate.longitude
                let location = CLLocation(latitude: lat!, longitude: long!)
                CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
                    if error != nil{
                        return
                    }else if let country = placemarks?.first?.country, let city = placemarks?.first?.locality{
                        print(country)
                        print(city)
                        self.weatherApi.getWeather(city: city)
                    }
                }
                break
            case .notDetermined, .restricted, .denied:
                print("Error...")
                break
            }
        }
    }
    
    func updateUI(){
        
    }
    
    
}

