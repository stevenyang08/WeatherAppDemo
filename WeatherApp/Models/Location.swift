//
//  Location.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

class Location: NSObject {

    private var _city: String?
    private var _state: String?
    private var _locationKey: String?
    
    init(dict: Dictionary<String, Any>) {
        
    }
    
    var locationKey: String {
        if (_locationKey == nil) {
            return ""
        }
        
        return _locationKey!
    }
}
