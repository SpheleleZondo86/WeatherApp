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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var image: UIImageView!
    
    var locatioManager = CLLocationManager()
    var currentLocation:CLLocation!
    let weatherApi = WeatherAPI.shared
    var spinner:UIView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
        spinner = UIViewController.displaySpinner(onView: self.view)
        weatherApi.downloadCurrentWeather {
            self.updateUI()
        }
        weatherApi.downloadWeatherFocust{
            self.tableView.reloadData()
        }
    }

    func setupLocation(){
        locatioManager.delegate = self
        locatioManager.requestWhenInUseAuthorization()
        locatioManager.desiredAccuracy = kCLLocationAccuracyBest
        locatioManager.startUpdatingLocation()
        locatioManager.startMonitoringSignificantLocationChanges()
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus(){
            case .authorizedAlways, .authorizedWhenInUse:
                print("Location Authorized!")
                currentLocation = locatioManager.location
                Location.sharedInstance.latitude = locatioManager.location?.coordinate.latitude
                Location.sharedInstance.longitude = locatioManager.location?.coordinate.longitude
                break
            case .notDetermined, .restricted, .denied:
                print("Error: Location either not determined, restricted, or denied!...")
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
        switch weatherType.text {
        case "Clear":
            self.view.backgroundColor = UIColor(hexString: "#47AB2F")
            self.image.image = UIImage(named: "forest_sunny")
        case "Sunny":
            self.view.backgroundColor = UIColor(hexString: "#47AB2F")
            self.image.image = UIImage(named: "forest_sunny")
        case "Cloudy":
            self.view.backgroundColor = UIColor(hexString: "#54717A")
            self.image.image = UIImage(named: "forest_cloudy")
        case "Clouds":
            self.view.backgroundColor = UIColor(hexString: "#54717A")
            self.image.image = UIImage(named: "forest_cloudy")
        default:
            self.view.backgroundColor = UIColor(hexString: "#57575D")
            self.image.image = UIImage(named: "forest_rainy")
        }
        UIViewController.removeSpinner(spinner: self.spinner!)
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherApi.focustArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as! ForecastCell
        cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.setupCell(forecast: self.weatherApi.focustArray[indexPath.row])
        return cell
    }
}















