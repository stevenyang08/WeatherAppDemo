//
//  Weather.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

private enum Keys: String {
    case EpochDate = "EpochDate"
    case Link = "MobileLink"
}

class Forecast {
    private var _epochDate: Int?
    private var _day: TimeOfDay?
    private var _night: TimeOfDay?
    private var _temperature: Temperature?
    private var _urlLink: String?

    init(dict: Dictionary<String, Any>) {
        _epochDate = dict[Keys.EpochDate.rawValue] as? Int
        _night = TimeOfDay(dict: dict, isNight: true)
        _day = TimeOfDay(dict: dict, isNight: false)
        _temperature = Temperature(dict: dict)
        _urlLink = dict[Keys.Link.rawValue] as? String
    }
    
    var date: Date {
        if (_epochDate == nil) {
            return Date()
        }
        
        return Date(timeIntervalSince1970: TimeInterval(_epochDate!))
    }
    
    var epochDate: Int {
        if (_epochDate == nil) {
            return 0
        }
        
        return _epochDate!
    }
    
    var temperature: Temperature {
        if (_temperature == nil) {
            return Temperature()
        }
        
        return _temperature!
    }
    
    var day: TimeOfDay {
        if (_day == nil) {
            return TimeOfDay()
        }
        
        return _day!
    }
    
    var night: TimeOfDay {
        if (_night == nil) {
            return TimeOfDay()
        }
        
        return _night!
    }
    
    var urlLink: String {
        if (_urlLink == nil) {
            return ""
        }
        
        return _urlLink!
    }
    
    var iconDayImage: UIImage {
        let image = UIImage(named: day.icon.intToString())
        
        if (image == nil) {
            return UIImage(named: "1")!
        }
        
        return image!
    }
    
    var iconNightImage: UIImage {
        let image = UIImage(named: night.icon.intToString())
        
        if (image == nil) {
            return UIImage(named: "1")!
        }
        
        return image!
    }
}
