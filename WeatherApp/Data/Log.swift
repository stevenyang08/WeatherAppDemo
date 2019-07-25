//
//  Log.swift
//  WeatherApp
//
//  Created by Steven on 7/24/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import Foundation
import Log

class LogManager {
    static let instance = LogManager()
    private init() {}
    
    public let Log = Logger()
    
    /*
     Log.trace("Called!!!")
     Log.debug("Who is self:", self)
     Log.info(some, objects, here)
     Log.warning(one, two, three, separator: " - ")
     Log.error(error, terminator: "😱😱😱\n")
     */
}
