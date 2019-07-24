//
//  Location.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

private enum Keys: String {
    case City = "LocalizedName"
    case LocationKey = "Key"
    case State = "AdministrativeArea"
    case Country = "Country"
    case Id = "ID"
}

class Location: NSObject, NSCoding {

    private var _city: String?
    private var _state: String?
    private var _country: String?
    private var _locationKey: String?
    
    init(dict: Dictionary<String, Any>) {
        _city = dict[Keys.City.rawValue] as? String
        _locationKey = dict[Keys.LocationKey.rawValue] as? String
        
        if let area = dict[Keys.State.rawValue] as? [String: Any], let state = area[Keys.Id.rawValue] as? String {
            _state = state
        }
        
        if let countryDict = dict[Keys.Country.rawValue] as? [String: Any], let country = countryDict[Keys.Id.rawValue] as? String {
            _country = country
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_city, forKey: Keys.City.rawValue)
        aCoder.encode(_state, forKey: Keys.State.rawValue)
        aCoder.encode(_country, forKey: Keys.Country.rawValue)
        aCoder.encode(_locationKey, forKey: Keys.LocationKey.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        _city = aDecoder.decodeObject(forKey: Keys.City.rawValue) as? String
        _state = aDecoder.decodeObject(forKey: Keys.State.rawValue) as? String
        _country = aDecoder.decodeObject(forKey: Keys.Country.rawValue) as? String
        _locationKey = aDecoder.decodeObject(forKey: Keys.LocationKey.rawValue) as? String
    }
    
    var locationKey: String {
        if (_locationKey == nil) {
            return ""
        }
        
        return _locationKey!
    }
    
    var city: String {
        if (_city == nil) {
            return ""
        }
        
        return _city!
    }
    
    var state: String {
        if (_state == nil) {
            return ""
        }
        
        return _state!
    }
    
    var country: String {
        if (_country == nil) {
            return ""
        }
        
        return _country!
    }
    
    func cityState() -> String {
        var string = city
        
        if country == "US" {
            string.append(", \(state)")
        } else {
            string.append(", \(country)")
        }
        
        return string
    }
}
