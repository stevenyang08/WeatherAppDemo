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
}

class Forecast {
    private var _epochDate: Int?
    private var _highTemp: Int?
    private var _lowTemp: Int?
    private var _urlLink: String?
    private var _imageIcon: Int?

    init(dict: Dictionary<String, Any>) {
        
    }
}
