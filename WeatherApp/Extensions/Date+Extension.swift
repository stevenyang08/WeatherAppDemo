//
//  Date+Extension.swift
//  WeatherApp
//
//  Created by Steven on 7/24/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import Foundation

extension Date {
    
    var dateToString: String {
        return "\(self)"
    }
    
    func dateToWeekDate() -> String {
        // Converts 2016-12-08 16:28:00 +0000
        // Returns Thursday, Jun 1, 2019
        
        let string = self.dateToString
        let stringDateFormatter = DateFormatter()
        stringDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        if let date = stringDateFormatter.date(from: string) {
            let getDateFormatter = DateFormatter()
            getDateFormatter.dateFormat = "E, MMM d, yyyy"
            let convertedDate = getDateFormatter.string(from: date)
            return convertedDate
        }
        
        return ""
    }
    
    func dateToWeekDay() -> String {
        // Converts 2016-12-08 16:28:00 +0000
        // Returns Thursday
        
        let string = self.dateToString
        let stringDateFormatter = DateFormatter()
        stringDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        if let date = stringDateFormatter.date(from: string) {
            let getDateFormatter = DateFormatter()
            getDateFormatter.dateFormat = "EEE"
            let convertedDate = getDateFormatter.string(from: date)
            return convertedDate
        }
        
        return ""
    }
    
    var dateToHour: Int {
        // Converts 2016-12-08 16:28:00 +0000
        // Returns the minutes
        let string = self.dateToString
        let stringDateFormatter = DateFormatter()
        stringDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        if let date = stringDateFormatter.date(from: string) {
            let getDateFormatter = DateFormatter()
            getDateFormatter.dateFormat = "H"
            let convertedDate = getDateFormatter.string(from: date)
            return Int(convertedDate) ?? 0
        }
        
        return 0
    }
}
