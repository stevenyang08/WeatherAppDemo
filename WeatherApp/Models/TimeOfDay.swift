//
//  DayTime.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

private enum Keys: String {
    case Day = "Day"
    case Night = "Night"
    case Icon = "Icon"
    case Phrase = "IconPhrase"
}

class TimeOfDay {
    private var _icon: Int?
    private var _iconPhrase: String?
    
    init(dict: Dictionary<String, Any>, isNight: Bool) {
        if isNight {
            if let night = dict[Keys.Night.rawValue] as? [String: Any],
                let icon = night[Keys.Icon.rawValue] as? Int,
                let phrase = night[Keys.Phrase.rawValue] as? String {
                print(night)
                _icon = icon
                _iconPhrase = phrase
            }
        } else {
            if let day = dict[Keys.Day.rawValue] as? [String: Any],
                let icon = day[Keys.Icon.rawValue] as? Int,
                let phrase = day[Keys.Phrase.rawValue] as? String {
                print(day)
                _icon = icon
                _iconPhrase = phrase
            }
        }
    }
    
    init() {
        _icon = 1
        _iconPhrase = ""
    }
    
    var icon: Int {
        if (_icon == nil) {
            return 1
        }
        
        return _icon!
    }
    
    var phrase: String {
        if (_iconPhrase == nil) {
            return ""
        }
        
        return _iconPhrase!
    }
}
