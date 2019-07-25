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
        return temperature.rounded(toPlaces: 1)
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var doubleToString: String {
        return String(self)
    }
    
    var mphToKmh: Double {
        let number = self * 1.609344
        return number
    }
}
