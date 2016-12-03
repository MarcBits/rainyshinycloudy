//
//  WeatherVC.swift
//  rainyshinycloudy
//
//  Created by Marc Cruz on 11/27/16.
//  Copyright © 2016 MarcBits. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var _selectedLat: Double?
    var selectedLat: Double? {
        get {
            if self._selectedLat == nil {
                return 0.0
            } else {
                return self._selectedLat
            }
        } set {
            if newValue == nil {
                self._selectedLat = 0.0
            } else {
                self._selectedLat = newValue
            }
            
            Location.sharedInstance.latitude = self._selectedLat
            
            print("Selected Lat: \(Location.sharedInstance.latitude!)")
        }
    }
    
    var _selectedLong: Double?
    var selectedLong: Double? {
        get {
            if self._selectedLong == nil {
                return 0.0
            } else {
                return self._selectedLong
            }
        } set {
            if newValue == nil {
                self._selectedLong = 0.0
            } else {
                self._selectedLong = newValue
            }
            
            Location.sharedInstance.longitude = self._selectedLong
            
            print("Selected Long: \(Location.sharedInstance.longitude!)")
        }
    }
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    var currentWeatherURL: String!
    var forecastWeatherURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {

        self.locationAuthStatus()
        self.constructLocationURLs()
        
        print(currentWeatherURL)  // debug
        print(forecastWeatherURL) // debug
        
        currentWeather = CurrentWeather(currentWeatherURL: currentWeatherURL)
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData {
                self.updateMainUI()
            }
        }
    }

    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            if Location.sharedInstance.latitude == nil
                || Location.sharedInstance.latitude == 0.0
                || Location.sharedInstance.longitude == nil
                || Location.sharedInstance.longitude == 0.0 {
            
                currentLocation = locationManager.location
                Location.sharedInstance.latitude = currentLocation.coordinate.latitude
                Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            }
            
            print(Location.sharedInstance.latitude, Location.sharedInstance.longitude) // debug

        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func constructLocationURLs() {
        constructCurrentWeatherURL()
        constructForecastWeatherURL()
    }
    
    func constructCurrentWeatherURL() {
        currentWeatherURL = (CURRENT_WEATHER_URL_TEMPLATE as NSString)
            .replacingOccurrences(of: "LTV", with: "\(Location.sharedInstance.latitude!)")
            .replacingOccurrences(of: "LGV", with: "\(Location.sharedInstance.longitude!)")
    }
    
    func constructForecastWeatherURL() {
        forecastWeatherURL = (FORECAST_WEATHER_URL_TEMPLATE as NSString)
            .replacingOccurrences(of: "LTV", with: "\(Location.sharedInstance.latitude!)")
            .replacingOccurrences(of: "LGV", with: "\(Location.sharedInstance.longitude!)")
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {

        let forecastURL = URL(string: forecastWeatherURL)!
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        
//                        print(obj)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()

                }
                
            }
            
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            
            return cell
            
        } else {
            
            return WeatherCell()
        }
        
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }

}

