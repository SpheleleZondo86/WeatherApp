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
    
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var minTemperature: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    
    var locatioManager = CLLocationManager()
    var currentLocation:CLLocation!
    let weatherApi = WeatherAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getWeatherData()
    }

    func getWeatherData() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus(){
            case .authorizedAlways, .authorizedWhenInUse:
                print("Location Authorized!")
                currentLocation = locatioManager.location
                Location.sharedInstance.latitude = locatioManager.location?.coordinate.latitude
                Location.sharedInstance.longitude = locatioManager.location?.coordinate.longitude
                weatherApi.downloadCurrentWeather {
                    self.updateUI()
                }
                break
            case .notDetermined, .restricted, .denied:
                print("Error: Location either not determined, restricted, or denied!...")
                break
            }
        }
    }
    func setupLocation(){
        locatioManager.delegate = self
        locatioManager.requestWhenInUseAuthorization()
        locatioManager.desiredAccuracy = kCLLocationAccuracyBest
        locatioManager.startUpdatingLocation()
        locatioManager.startMonitoringSignificantLocationChanges()
    }
    
    func updateUI(){
        let weatherInDegreesCelsius = Int(weatherApi.currentWeather.currentTemperature - 274.15)
        let minWeatherInDegreesCelsius = Int(weatherApi.currentWeather.minTemperature - 274.15)
        let maxWeatherInDegreesCelsius = Int(weatherApi.currentWeather.maxTemperature - 274.15)
        currentTemperature.text = "\(weatherInDegreesCelsius) °"
        currentTemp.text = "\(weatherInDegreesCelsius) °"
        minTemperature.text = "\(minWeatherInDegreesCelsius) °"
        maxTemperature.text = "\(maxWeatherInDegreesCelsius) °"
        weatherType.text = weatherApi.currentWeather.weatherType
    }
    
    
}

