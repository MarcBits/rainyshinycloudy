//
//  Location.swift
//  rainyshinycloudy
//
//  Created by Marc Cruz on 12/2/16.
//  Copyright © 2016 MarcBits. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
