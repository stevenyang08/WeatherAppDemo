//
//  StateData.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

class StateData {
    static let instance = StateData()
    private init() {}
    
    public var location = Location()
    public var isMetric: Bool = false
    public var isNight: Bool = false
    public var madeChanges: Bool = false
    
    public var latitude = 0.0
    public var longitude = 0.0
}
