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
let FORECAST_TYPE = "/forecast/daily"
let FORECAST_LEN = 11   // we take out position 0; len = n-1
let LATITUDE = "lat="
let LAT_VALUE = "LTV"
let LONG_VALUE = "LGV"
let LONGITUDE = "&lon="
let CNT = "&cnt="
let MODE = "&mode=json"
let APP_ID = "&appid="

let API_KEY = MY_API_KEY    // Define a key from OpenWeatherMap.org in constants file as "MY_API_KEY"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL_TEMPLATE = "\(BASE_URL)\(WEATHER)?\(LATITUDE)\(LAT_VALUE)\(LONGITUDE)\(LONG_VALUE)\(APP_ID)\(API_KEY)"

let FORECAST_WEATHER_URL_TEMPLATE = "\(BASE_URL)\(FORECAST_TYPE)?\(LATITUDE)\(LAT_VALUE)\(LONGITUDE)\(LONG_VALUE)\(CNT)\(FORECAST_LEN)\(MODE)\(APP_ID)\(API_KEY)"
