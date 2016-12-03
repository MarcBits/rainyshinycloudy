//
//  CurrentWeather.swift
//  rainyshinycloudy
//
//  Created by Marc Cruz on 11/30/16.
//  Copyright © 2016 MarcBits. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    
    var currentWeatherURL: String
    init(currentWeatherURL url: String) {
        currentWeatherURL = url
    }
    
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        // Alamofire download
        let currentWeatherURL = URL(string: self.currentWeatherURL)!

        Alamofire.request(currentWeatherURL).responseJSON {
            response in
                
            let result = response.result
                
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    
//                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        
//                        print(self._weatherType)
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let temp = main["temp"] as? Double {
                        
                        let kelvinToFarenheitUnrounded = (temp * (9/5)) - 459.67
                        let kelvinToFarenheitRounded = self.roundToPlaces(value: kelvinToFarenheitUnrounded, decimalPlaces: 1)

                        self._currentTemp = kelvinToFarenheitRounded
                        
//                        print(self._currentTemp)
                    }
                }
                
            }
            
            completed()
        }
        
    }
    
    func roundToPlaces(value: Double, decimalPlaces: Int) -> Double {
        let divisor = pow(10.0, Double(decimalPlaces))
        return round(value * divisor) / divisor
    }
}
