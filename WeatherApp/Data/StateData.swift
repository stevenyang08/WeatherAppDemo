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
    
    var location: Location?
    
    let staticLocationKey = "348794"
}
