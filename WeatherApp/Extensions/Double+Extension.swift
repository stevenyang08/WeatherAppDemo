//
//  Double+Extension.swift
//  WeatherApp
//
//  Created by Steven on 7/23/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import Foundation

extension Double {
    
    func convertToCelsius() -> Double {
        let temperature = (self - 32) / 1.8
        return temperature
    }
}
