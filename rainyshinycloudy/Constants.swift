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
let API_KEY = "76f00482b34f6e77aaa1c54476c8c0e7"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)35\(LONGITUDE)139\(APP_ID)\(API_KEY)"

