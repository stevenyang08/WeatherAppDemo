//
//  PersistenceManager.swift
//  WeatherApp
//
//  Created by Steven on 7/24/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import Foundation

enum PersistencePath: String {
    case IsMetric = "isMetric"
    case Location = "Location"
}

class PersistenceManager {
    class fileprivate func documentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = paths[0] as String
        return documentDirectory as NSString
    }
    
    class func save(_ save: AnyObject, path: PersistencePath) {
        let filePath = documentsDirectory().appendingPathComponent(path.rawValue)
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: save, requiringSecureCoding: false)
            try data.write(to: filePath.asURL())
            print("Success saving data")
        } catch let err {
            print("Error saving data. \(err)")
        }
    }
    
    class func load(_ path: PersistencePath) -> AnyObject? {
        let filePath = documentsDirectory().appendingPathComponent(path.rawValue)
        
        do {
            guard let nsData = try NSData(contentsOf: filePath.asURL()) else {
                return nil
            }
            
            let data = Data(referencing: nsData)
            if let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) {
                print("Success loading data")
                return object as AnyObject
            }
        } catch let err {
            print("Error loading data. \(err)")
            return nil
        }
        
        return nil
    }
}
