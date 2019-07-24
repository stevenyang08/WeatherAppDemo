//
//  PersistenceManager.swift
//  WeatherApp
//
//  Created by Steven on 7/24/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import Foundation

enum PersistencePath: String {
    case IsMetric = "IsMetric"
    case Location = "Location"
}

class PersistenceManager {
    class fileprivate func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    class func save(_ save: AnyObject, path: PersistencePath) {
        let filePath = documentsDirectory().appendingPathComponent(path.rawValue)
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: save, requiringSecureCoding: false)
            try data.write(to: filePath)
            print("Success saving data")
        } catch let err {
            print("Error saving data. \(err)")
        }
    }
    
    class func load(_ path: PersistencePath) -> AnyObject? {
        let filePath = documentsDirectory().appendingPathComponent(path.rawValue)
        
        do {
            if let nsData = NSData(contentsOf: filePath)  {
                let data = Data(referencing: nsData)
                if let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) {
                    print("Success loading data")
                    return object as AnyObject
                }
            }
        } catch let err {
            print("Error loading data. \(err)")
            return nil
        }
        
        return nil
    }
}
