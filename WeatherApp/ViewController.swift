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
    let weatherApi = WeatherAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
        weatherApi.downloadCurrentWeather {
            self.updateUI()
        }
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
                        //self.weatherApi.getWeather(city: city)
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

