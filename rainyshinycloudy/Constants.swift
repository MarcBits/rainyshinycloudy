//
//  Constants.swift
//  rainyshinycloudy
//
//  Created by Marc Cruz on 11/30/16.
//  Copyright © 2016 MarcBits. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5"
let WEATHER = "/weather"
let FORECAST_16 = "/forecast/daily"
let LATITUDE = "lat="
let LAT_VALUE = "43.137326"     // Penfield; at some point this will be dynamic
let LONG_VALUE = "-77.464830"   // Penfield; at some point this will be dynamic
let LONGITUDE = "&lon="
let CNT = "&cnt="
let MODE = "&mode=json"
let APP_ID = "&appid="

let API_KEY = MY_API_KEY    // Define a key from OpenWeatherMap.org in constants file as "MY_API_KEY"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(WEATHER)?\(LATITUDE)\(LAT_VALUE)\(LONGITUDE)\(LONG_VALUE)\(APP_ID)\(API_KEY)"

let FORECAST_WEATHER_URL = "\(BASE_URL)\(FORECAST_16)?\(LATITUDE)\(LAT_VALUE)\(LONGITUDE)\(LONG_VALUE)\(CNT)16\(MODE)\(APP_ID)\(API_KEY)"

//http://api.openweathermap.org/data/2.5/weather?lat=43.137326&lon=-77.464830&appid=a6cbf0227981e129f569f0b4ba812313
//http://api.openweathermap.org/data/2.5/forecast/daily?lat=43.137326&lon=-77.464830&cnt=16&mode=json&appid=a6cbf0227981e129f569f0b4ba812313
