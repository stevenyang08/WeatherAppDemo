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
    case Current = "Imperial"
    case Degrees = "Value"
}

class Temperature {
    private var _highTemp: Int?
    private var _lowTemp: Int?
    private var _currentTemp: Int?

    init(dict: Dictionary<String, Any>) {
        if let tempDictionary = dict[Keys.Temperature.rawValue] as? [String: Any] {
            // FOR CURRENT TEMPERATURE, API SUCKS AND ONLY GIVES YOU LIMITED DATA
            if let currentDict = tempDictionary[Keys.Current.rawValue] as? [String: Any],
                let currentTemp = currentDict[Keys.Degrees.rawValue] as? Int {
                    _currentTemp = currentTemp
            } else if let maximumDict = tempDictionary[Keys.Maximum.rawValue] as? [String: Any],
                let minimumDict = tempDictionary[Keys.Minimum.rawValue] as? [String: Any] {
                
                if let highTemp = maximumDict[Keys.Degrees.rawValue] as? Int,
                    let lowTemp = minimumDict[Keys.Degrees.rawValue] as? Int {
                    _highTemp = highTemp
                    _lowTemp = lowTemp
                }
            }
        }
    }
    
    init() {
        _lowTemp = 0
        _highTemp = 0
        _currentTemp = 0
    }
    
    var currentTemp: Double {
        if (_currentTemp == nil) {
            return 0.0
        }
        
        return _currentTemp!.intToDouble()
    }
    
    var highTemp: Double {
        if (_highTemp == nil) {
            return 0.0
        }
        
        return _highTemp!.intToDouble()
    }
    
    var lowTemp: Double {
        if (_lowTemp == nil) {
            return 0.0
        }
        
        return _lowTemp!.intToDouble()
    }
    
    var currentTempString: String {
        switch (StateData.instance.isMetric) {
        case true:
            return String("\(currentTemp.convertToCelsius())°C")
        case false:
            return String("\(currentTemp)°F")
        }
    }
    
    var highTempString: String {
        switch (StateData.instance.isMetric) {
        case true:
            return String("\(highTemp.convertToCelsius())°C")
        case false:
            return String("\(highTemp)°F")
        }
    }
    
    var lowTempString: String {
        switch (StateData.instance.isMetric) {
        case true:
            return String("\(lowTemp.convertToCelsius())°C")
        case false:
            return String("\(lowTemp)°F")
        }
    }
}
