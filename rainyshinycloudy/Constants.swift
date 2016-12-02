//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by Marc Cruz on 11/30/16.
//  Copyright © 2016 MarcBits. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="

let API_KEY = MY_API_KEY    // Define a key from OpenWeatherMap.org in constants file as "MY_API_KEY"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)35\(LONGITUDE)139\(APP_ID)\(API_KEY)"

