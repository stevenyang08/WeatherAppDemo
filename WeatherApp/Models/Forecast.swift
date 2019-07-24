//
//  Weather.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

private enum Keys: String {
    case Time = "time"
    case Summary = "summary"
    case Icon = "icon"
    case Temperature = "temperature"
    case ApparentTemperature = "apparentTemperature"
    case TempHigh = "temperatureHigh"
    case TempLow = "temperatureLow"
    case ApparentTempHigh = "apparentTemperatureHigh"
    case ApparentTempLow = "apparentTemperatureLow"
    case Humidity = "humidity"
    case WindSpeed = "windSpeed"
}

enum TemperatureType {
    case Temperature
    case ApparentTemperature
    case TemperatureHigh
    case TemperatureLow
}

class Forecast {
    private var _time: Int?
    private var _summary: String?
    private var _icon: String?
    private var _temperature: Double?
    private var _apparentTemperature: Double?
    private var _tempHigh: Double?
    private var _tempLow: Double?
    private var _apparentTemperatureHigh: Double?
    private var _apparentTemperatureLow: Double?
    private var _humidity: Double?
    private var _windSpeed: Double?

    init(dict: Dictionary<String, Any>, _ currentDict: Dictionary<String, Any>? = nil) {
        _time = dict[Keys.Time.rawValue] as? Int
        _summary = dict[Keys.Summary.rawValue] as? String
        _icon = dict[Keys.Icon.rawValue] as? String
        
        if let current = currentDict,
            let temperature = current[Keys.Temperature.rawValue] as? Double,
            let apparentTemperature = current[Keys.Temperature.rawValue] as? Double {
                _temperature = temperature
                _apparentTemperature = apparentTemperature
        }
        
        if let tempHigh = dict[Keys.TempHigh.rawValue] as? Double, let tempLow = dict[Keys.TempLow.rawValue] as? Double {
            _tempHigh = tempHigh
            _tempLow = tempLow
        }
        
        if let appTemperatureHigh = dict[Keys.ApparentTempHigh.rawValue] as? Double, let appTemperatureLow = dict[Keys.ApparentTempLow.rawValue] as? Double {
            _apparentTemperatureHigh = appTemperatureHigh
            _apparentTemperatureLow = appTemperatureLow
        }
        
        _humidity = dict[Keys.Humidity.rawValue] as? Double
        _windSpeed = dict[Keys.WindSpeed.rawValue] as? Double
    }
    
    var date: Date {
        if (_time == nil) {
            return Date()
        }
        
        return Date(timeIntervalSince1970: TimeInterval(_time!))
    }
    
    var epochDate: Int {
        if (_time == nil) {
            return 0
        }
        
        return _time!
    }
    
    var summary: String {
        if (_summary == nil) {
            return ""
        }
        
        return _summary!
    }
    
    var weather: String {
        let newString = icon.replacingOccurrences(of: "-", with: " ").capitalized
        
        return newString
    }
    
    var icon: String {
        if (_icon == nil) {
            return "clear-day"
        }
        
        return _icon!
    }
    
    var iconImage: UIImage {
        if (_icon == nil) {
            return UIImage(named: "clear-day")!
        }

        return UIImage(named: _icon!)!
    }
    
    var temperature: Double {
        get {
            if (_temperature == nil) {
                return averageNumber([temperatureHigh, temperatureLow])
            }
            
            return _temperature!
        } set {
            _temperature = newValue
        }
    }
    
    var temperatureHigh: Double {
        if (_tempHigh == nil) {
            return 0.0
        }
        return _tempHigh!
    }
    
    var temperatureLow: Double {
        if (_tempLow == nil) {
            return 0.0
        }
        return _tempLow!
    }
    
    var apparentTemperature: Double {
        get {
            if (_apparentTemperature == nil) {
                return averageNumber([apparentTempHigh, apparentTempLow])
            }
            
            return _apparentTemperature!
        } set {
            _apparentTemperature = newValue
        }
    }
    
    private var apparentTempHigh: Double {
        if (_apparentTemperatureHigh == nil) {
            return 0.0
        }
        return _apparentTemperatureHigh!
    }
    
    private var apparentTempLow: Double {
        if (_apparentTemperatureLow == nil) {
            return 0.0
        }
        return _apparentTemperatureLow!
    }
    
    func temperatureString(temperatureType: TemperatureType) -> String {
        var newTemperature = 0.0
        switch temperatureType {
        case .Temperature:
            newTemperature = temperature.rounded(toPlaces: 1)
        case .ApparentTemperature:
            newTemperature = apparentTemperature.rounded(toPlaces: 1)
        case .TemperatureHigh:
            newTemperature = temperatureHigh.rounded(toPlaces: 1)
        case .TemperatureLow:
            newTemperature = temperatureLow.rounded(toPlaces: 1)
        }
        
        if (StateData.instance.isMetric) {
            return String("\(newTemperature.convertToCelsius())°C")
        }
    
        return String("\(newTemperature)°F")
    }
    
    func averageNumber(_ doubleArray: [Double]) -> Double {
        let averageNumber = doubleArray.reduce(0) { x, y in
            x + y
        }
        return averageNumber / doubleArray.count.intToDouble()
    }
}

