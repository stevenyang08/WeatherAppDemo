//
//  Temperature.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

private enum Keys: String {
    case Temperature = "Temperature"
    case Minimum = "Minimum"
    case Maximum = "Maximum"
    case Degrees = "Value"
}

class Temperature {
    private var _highTemp: Int?
    private var _lowTemp: Int?

    init(dict: Dictionary<String, Any>) {
        if let tempDictionary = dict[Keys.Temperature.rawValue] as? [String: Any] {
            if let maximumDict = tempDictionary[Keys.Maximum.rawValue] as? [String: Any], let degrees = maximumDict[Keys.Degrees.rawValue] as? Int {
                _highTemp = degrees
            }
            
            if let minimumDict = tempDictionary[Keys.Minimum.rawValue] as? [String: Any], let degrees = minimumDict[Keys.Degrees.rawValue] as? Int {
                _lowTemp = degrees
            }
        }
    }
    
    var highTemp: Double? {
        if (_highTemp == nil) {
            return 0.0
        }
        
        return _highTemp!.intToDouble()
    }
    
    var lowTemp: Double? {
        if (_lowTemp == nil) {
            return 0.0
        }
        
        return _lowTemp!.intToDouble()
    }
}
