//
//  Location.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

class Location {

    private var _city: String?
    private var _state: String?
    private var _country: String?
    private var _latitude: Double?
    private var _longitude: Double?
    
    init() {}
    
    var city: String {
        get {
            if (_city == nil) {
                return ""
            }
            
            return _city!
        } set {
            _city = newValue
        }
    }
    
    var state: String {
        get {
            if (_state == nil) {
                return ""
            }
            
            return _state!
        } set {
            _state = newValue
        }
    }
    
    var country: String {
        get {
            if (_country == nil) {
                return ""
            }
            
            return _country!
        } set {
            _country = newValue
        }
    }
    
    var latitude: Double {
        get {
            if (_latitude == nil) {
                return 0.0
            }
            
            return _latitude!
        } set {
            _latitude = newValue
        }
    }
    
    var longitude: Double {
        get {
            if (_longitude == nil) {
                return 0.0
            }
            
            return _longitude!
        } set {
            _longitude = newValue
        }
    }
    
    func cityState() -> String {
        if (_city == nil) {
            return "Select Location"
        }
        
        var string = city
        
        if country == "US" {
            string.append(", \(state)")
        } else {
            string.append(", \(country)")
        }
        
        return string
    }
}
